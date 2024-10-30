#standardSQL
# Robots txt user agent usage


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
    var uas = robots_txt.record_counts.by_useragent;
    result.user_agents  = typeof uas === 'object' ? Object.keys(uas).map(ua => ua.toLowerCase()) : [];
} catch (e) {}
return result;
''';


WITH robots AS (
  SELECT
    client,
    root_page,
    getRobotsTxtUserAgents(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_user_agent_info,
    COUNT(DISTINCT root_page) OVER (PARTITION BY client) AS total_sites
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
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
