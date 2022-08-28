CREATE TEMPORARY FUNCTION isLCPPreloaded(payload STRING) RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var lcp_url = $._performance.lcp_elem_stats.url;

  var almanac = JSON.parse($._almanac);
  return !!almanac['link-nodes'].nodes.find(link => {
    return link.rel && link.rel.toLowerCase() == 'preload' && lcp_url.endsWith(link.href);
  });
} catch (e) {
  return false;
}
''';

WITH preloaded AS (
  SELECT
    _TABLE_SUFFIX AS client,
    isLCPPreloaded(payload) AS is_lcp_preloaded
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  COUNTIF(is_lcp_preloaded) AS lcp_preloaded,
  COUNT(0) AS total,
  COUNTIF(is_lcp_preloaded) / COUNT(0) AS pct_lcp_preloaded
FROM
  preloaded
GROUP BY
  client
