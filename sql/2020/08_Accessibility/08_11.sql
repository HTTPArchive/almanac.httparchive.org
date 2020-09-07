#standardSQL
# 08_11: % sites with links to to the same page, # or javascript:void
# TODO: Does same_page.total include hash_link occurances?
CREATE TEMPORARY FUNCTION getLinkStats(payload STRING)
RETURNS STRUCT<same_page INT64, hash_only_link INT64, javascript_void_links INT64> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var anchors = JSON.parse($._wpt_bodies).anchors.rendered;
  return {
    same_page: anchors.same_page.total,
    hash_only_link: anchors.hash_only_link,
    javascript_void_links: anchors.javascript_void_links,
  };
} catch (e) {
  return [];
}
''';
SELECT
  client,
  COUNT(0) AS total_sites,

  COUNTIF(link_stats.same_page > 0) AS has_same_page,
  COUNTIF(link_stats.hash_only_link > 0) AS has_hash_only_link,
  COUNTIF(link_stats.javascript_void_links > 0) AS has_javascript_void_links,

  ROUND((COUNTIF(link_stats.same_page > 0) / COUNT(0)) * 100, 2) AS pct_has_same_page,
  ROUND((COUNTIF(link_stats.hash_only_link > 0) / COUNT(0)) * 100, 2) AS pct_has_hash_only_link,
  ROUND((COUNTIF(link_stats.javascript_void_links > 0) / COUNT(0)) * 100, 2) AS pct_has_javascript_void_links
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getLinkStats(payload) AS link_stats
  FROM
    `httparchive.almanac.pages_desktop_*`
)
GROUP BY
  client
