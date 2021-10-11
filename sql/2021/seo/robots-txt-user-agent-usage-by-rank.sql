#standardSQL
# Robots txt user agent usage by rank


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

SELECT
  client,
  user_agent,
  rank,
  COUNT(DISTINCT page) AS pages,
  COUNT(DISTINCT page) / rank AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank AS _rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`)
LEFT JOIN (
  SELECT
    DISTINCT _TABLE_SUFFIX AS client,
    user_agent,
    url AS page
  FROM (
    SELECT
      _TABLE_SUFFIX,
      url,
      getRobotsTxtUserAgents(JSON_EXTRACT_SCALAR(payload,
          '$._robots_txt')) AS robots_txt_user_agent_info
    FROM
      `httparchive.pages.2021_07_01_*`),
    UNNEST(robots_txt_user_agent_info.user_agents) AS user_agent )
USING
  (client,
    page),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank
WHERE
  _rank <= rank
GROUP BY
  client,
  user_agent,
  rank
HAVING
  pages > 20
ORDER BY
  rank,
  pct DESC
