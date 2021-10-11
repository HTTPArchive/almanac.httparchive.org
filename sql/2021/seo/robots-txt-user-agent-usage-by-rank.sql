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


SELECT
  client,
  user_agent,
  rank_grouping,
  rank_page_count,
  COUNT(DISTINCT page) AS pages,
  SAFE_DIVIDE(COUNT(DISTINCT page),
    rank_page_count) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_page_count,
    url AS page,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  LEFT JOIN (
    SELECT
      rank,
      COUNT(DISTINCT(url)) AS rank_page_count
    FROM
      `httparchive.summary_pages.2021_07_01_*`
    GROUP BY
      rank )
  USING
    (rank))
LEFT JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
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
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  client,
  user_agent,
  rank_grouping,
  rank_page_count
HAVING
  pages > 50
ORDER BY
  rank_grouping,
  pct DESC
