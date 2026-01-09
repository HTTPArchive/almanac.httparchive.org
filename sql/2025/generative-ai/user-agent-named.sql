#standardSQL
# Percent of sites with a given user-agent mentioned in robots.txt, by rank bucket
# Returns percentages among (a) all sites and (b) only sites with robots.txt status=200.

CREATE TEMP FUNCTION getByAgent(byua_json JSON, agent STRING)
RETURNS JSON
LANGUAGE js AS r"""
  try {
    const key = String(agent || '').toLowerCase();
    const rec = byua_json[key];
    return rec;
  } catch (e) { return null; }
""";

-- Base rows: one per site
WITH base AS (
  SELECT
    client,
    rank,
    root_page,
    SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.status) AS INT64) AS status,
    custom_metrics.robots_txt.record_counts.by_useragent AS byua
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page
),

-- Extract all UA keys present on each site (keys of by_useragent object)
ua_keys AS (
  SELECT
    b.client,
    b.rank,
    b.root_page,
    LOWER(agent) AS agent
  FROM
    base AS b,
    UNNEST(
      REGEXP_EXTRACT_ALL(TO_JSON_STRING(b.byua), r'"([^"]+)":\{')
    ) AS agent
),

-- Per-site per-agent presence (any directive count > 0)
ua_presence AS (
  SELECT
    k.client,
    k.rank,
    k.root_page,
    k.agent,
    -- Look up this agent's counts without reparsing the whole robots again
    getByAgent(b.byua, k.agent) AS agent_obj
  FROM
    ua_keys k
  JOIN
    base b
  USING (client, rank, root_page)
),

ua_presence_scored AS (
  SELECT
    client,
    rank,
    root_page,
    agent,
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.allow) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.disallow) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.crawl_delay) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.noindex) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.other) AS INT64), 0) AS rules_sum
  FROM
    ua_presence
),

-- Totals per rank bucket
totals_all AS (
  SELECT
    client,
    rank,
    COUNT(DISTINCT root_page) AS total_sites
  FROM
    base
  GROUP BY
    client,
    rank
),

totals_200 AS (
  SELECT
    client,
    rank,
    COUNT(DISTINCT root_page) AS total_sites_200
  FROM
    base
  WHERE
    status = 200
  GROUP BY
    client,
    rank
),

-- Numerators per agent
numerators AS (
  SELECT
    p.client,
    p.rank,
    p.agent,
    COUNT(DISTINCT p.root_page) AS sites_with_agent,
    COUNT(DISTINCT IF(b.status = 200, p.root_page, NULL)) AS sites_with_agent_among_200
  FROM
    ua_presence_scored p
  JOIN
    base b
  USING (client, rank, root_page)
  WHERE
    p.rules_sum > 0
  GROUP BY
    p.client,
    p.rank,
    p.agent
)

SELECT
  n.client,
  n.rank,
  n.agent,
  t.total_sites,
  t2.total_sites_200,
  n.sites_with_agent,
  n.sites_with_agent_among_200,
  SAFE_DIVIDE(n.sites_with_agent, t.total_sites) AS pct_of_all_sites,
  SAFE_DIVIDE(n.sites_with_agent_among_200, t2.total_sites_200) AS pct_of_sites_with_200
FROM
  numerators n
JOIN
  totals_all t
USING (client, rank)
JOIN
  totals_200 t2
USING (client, rank)
ORDER BY
  rank,
  client,
  pct_of_all_sites DESC;
