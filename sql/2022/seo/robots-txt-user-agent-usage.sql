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

SELECT
  client,
  user_agent,
  total,
  COUNT(0) AS count,
  SAFE_DIVIDE(COUNT(0), total) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    getRobotsTextUserAgents(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_user_agent_info
  FROM
    `httparchive.pages.2022_07_01_*` -- noqa: CV09
  JOIN (

    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
      `httparchive.pages.2022_07_01_*` -- noqa: CV09
    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
  UNNEST(robots_txt_user_agent_info.user_agents) AS user_agent
GROUP BY
  total,
  user_agent,
  client
HAVING
  count >= 20
ORDER BY
  count DESC
