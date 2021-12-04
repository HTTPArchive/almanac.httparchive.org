#standardSQL
# Count of pages using native image lazy loading
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
  `httparchive.pages.2021_07_01_*`
GROUP BY
  client
ORDER BY
  client,
  freq DESC
