#standardSQL
-- Percent of sites mentioning each user-agent in robots.txt, over fixed Almanac snapshots

CREATE TEMP FUNCTION getByAgent(byua_json JSON, agent STRING)
RETURNS JSON
LANGUAGE js AS r"""
  try {
    const rec = byua_json[String(agent || '').toLowerCase()];
    return rec;
  } catch (e) { return null; }
""";

-- Base: one row per site snapshot (only fields we need)
WITH base AS (
  SELECT
    date,
    client,
    rank,
    root_page,
    SAFE_CAST(JSON_VALUE(custom_metrics.robots_txt.status) AS INT64) AS status,
    custom_metrics.robots_txt.record_counts.by_useragent AS byua
  FROM
    `httparchive.crawl.pages`
  WHERE
    date IN ('2019-07-01', '2020-08-01', '2021-07-01', '2022-06-01', '2024-06-01', '2025-07-01') AND
    client = 'mobile' AND
    is_root_page
),

-- Extract UA keys present on each site
ua_keys AS (
  SELECT
    b.date, b.client, b.rank, b.root_page,
    LOWER(agent) AS agent
  FROM
    base AS b,
    UNNEST(REGEXP_EXTRACT_ALL(TO_JSON_STRING(b.byua), r'"([^"]+)":\{')) AS agent
),

-- Look up that agent’s counts on that site
ua_presence AS (
  SELECT
    k.date,
    k.client,
    k.rank,
    k.root_page,
    k.agent,
    getByAgent(b.byua, k.agent) AS agent_obj,
    b.status
  FROM
    ua_keys k
  JOIN
    base b
  USING (date, client, rank, root_page)
),

-- Sum rule counts and keep only sites where the agent actually appears
ua_scored AS (
  SELECT
    date,
    client,
    rank,
    root_page,
    agent,
    status,
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.allow) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.disallow) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.crawl_delay) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.noindex) AS INT64), 0) +
    COALESCE(SAFE_CAST(JSON_VALUE(agent_obj.other) AS INT64), 0) AS rules_sum
  FROM
    ua_presence
),

-- Denominators per (date, rank)
totals_all AS (
  SELECT
    date,
    client,
    rank,
    COUNT(DISTINCT root_page) AS total_sites
  FROM
    base
  GROUP BY
    date,
    client,
    rank
),

totals_200 AS (
  SELECT
    date,
    client,
    rank,
    COUNT(DISTINCT root_page) AS total_sites_200
  FROM
    base
  WHERE
    status = 200
  GROUP BY
    date,
    client,
    rank
),

-- Numerators per (date, rank, agent)
numerators AS (
  SELECT
    date, client, rank, agent,
    COUNT(DISTINCT IF(rules_sum > 0, root_page, NULL)) AS sites_with_agent,
    COUNT(DISTINCT IF(status = 200 AND rules_sum > 0, root_page, NULL)) AS sites_with_agent_among_200
  FROM
    ua_scored
  GROUP BY
    date,
    client,
    rank,
    agent
)

SELECT
  n.date,
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
USING (date, client, rank)
JOIN
  totals_200 t2
USING (date, client, rank)
WHERE
  n.sites_with_agent >= 100
ORDER BY
  n.date,
  n.rank,
  pct_of_all_sites DESC;
