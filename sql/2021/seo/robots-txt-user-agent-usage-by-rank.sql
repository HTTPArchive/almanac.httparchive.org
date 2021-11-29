#standardSQL
# Robots txt user agent usage BY rank

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION getRobotsTxtUserAgents(robots_txt_string STRING)
RETURNS STRUCT<
  user_agents ARRAY<STRING>
> LANGUAGE js AS '''
var result = {
  user_agents: []
};
try {
    var robots_txt = JSON.parse(robots_txt_string);
    if (Array.isArray(robots_txt) || typeof robots_txt != 'object') return result;
    if (robots_txt.user_agents) {
      var uas = robots_txt.user_agents.map(ua => ua.toLowerCase());
      var uas =  uas.filter(function(item, pos) { return uas.indexOf(item) == pos;}); // remove duplicates
      result.user_agents = uas;
    }
} catch (e) {}
return result;
''';

WITH totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    COUNT(0) AS rank_page_count
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    client,
    rank_grouping
),

robots AS (
  SELECT
    _TABLE_SUFFIX,
    url,
    getRobotsTxtUserAgents(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_user_agent_info
  FROM
    `httparchive.pages.2021_07_01_*`
),

base AS (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    user_agent,
    rank,
    url AS page
  FROM
    robots,
    UNNEST(robots_txt_user_agent_info.user_agents) AS user_agent
  JOIN
    `httparchive.summary_pages.2021_07_01_*`
  USING (_TABLE_SUFFIX, url)
)

SELECT
  client,
  user_agent,
  rank_grouping,
  CASE
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  rank_page_count,
  COUNT(DISTINCT page) AS pages,
  SAFE_DIVIDE(COUNT(DISTINCT page), rank_page_count) AS pct
FROM
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
JOIN
  totals
USING (client, rank_grouping)
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  user_agent,
  rank_grouping,
  rank_page_count
HAVING
  pages > 500
ORDER BY
  rank_grouping,
  pct DESC
