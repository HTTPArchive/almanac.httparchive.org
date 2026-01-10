#standardSQL
# Robots txt user agent usage


# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION getRobotsTxtUserAgents(robots_txt JSON)
RETURNS STRUCT<
  user_agents ARRAY<STRING>
> LANGUAGE js AS '''
var result = {
  user_agents: []
};
try {
    var uas = robots_txt.record_counts.by_useragent;
    result.user_agents  = typeof uas === 'object' ? Object.keys(uas).map(ua => ua.toLowerCase()) : [];
} catch (e) {}
return result;
''';


WITH robots AS (
  SELECT
    client,
    root_page,
    getRobotsTxtUserAgents(custom_metrics.robots_txt) AS robots_txt_user_agent_info,
    COUNT(DISTINCT root_page) OVER (PARTITION BY client) AS total_sites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  user_agent,
  COUNT(DISTINCT root_page) AS sites,
  COUNT(DISTINCT root_page) / ANY_VALUE(total_sites) AS pct
FROM
  robots,
  UNNEST(robots_txt_user_agent_info.user_agents) AS user_agent
GROUP BY
  user_agent,
  client
HAVING
  sites >= 20
ORDER BY
  sites DESC
