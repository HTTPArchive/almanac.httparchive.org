#standardSQL
# 21_12a: Count of pages using native lazy loading
CREATE TEMPORARY FUNCTION nativeLazyLoads(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac.images.loading_values.length > 0;
} catch (e) {
  return false;
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  COUNTIF(nativeLazyLoads(payload)) AS freq,
  COUNT(0) AS total,
  COUNTIF(nativeLazyLoads(payload)) / COUNT(0) AS pct
FROM
  `httparchive.pages.2020_08_01_*`
GROUP BY
  client
