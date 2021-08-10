#standardSQL
# pages robots_txt metrics grouped by device and status code

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# returns all the data we need from _robots_txt
CREATE TEMPORARY FUNCTION get_robots_txt_info(robots_txt_string STRING)
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
  AS_PERCENT(COUNT(0), total) AS pct
FROM
(
  SELECT
    _TABLE_SUFFIX AS client,
    total,
    get_robots_txt_info(JSON_EXTRACT_SCALAR(payload, '$._robots_txt')) AS robots_txt_info
  FROM
    `httparchive.pages.2020_08_01_*`
  JOIN
  (
    # to get an accurate total of pages per device. also seems fast
    SELECT _TABLE_SUFFIX, COUNT(0) AS total
    FROM
    `httparchive.pages.2020_08_01_*`
    GROUP BY _TABLE_SUFFIX
  )
  USING (_TABLE_SUFFIX)
),
UNNEST(robots_txt_info.user_agents) AS user_agent
GROUP BY total, user_agent, client
HAVING count >= 100
ORDER BY count DESC
