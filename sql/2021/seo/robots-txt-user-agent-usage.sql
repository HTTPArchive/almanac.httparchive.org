#standardSQL
# Robots txt user agent usage


# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION getRobotsTextUserAgents(robots_txt_string STRING)
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
    `httparchive.pages.2021_07_01_*`
  JOIN (

    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
      `httparchive.pages.2021_07_01_*`
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
