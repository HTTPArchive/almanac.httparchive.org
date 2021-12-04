#standardSQL
# Percent of pages with CSS sourcemaps.
CREATE TEMPORARY FUNCTION countSourcemaps(payload STRING) RETURNS INT64 LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var sass = JSON.parse($._sass);
  return sass.sourcemaps.count;
} catch (e) {
  return 0;
}
''';

SELECT
  client,
  COUNTIF(has_sourcemap) AS freq,
  COUNT(0) AS total,
  COUNTIF(has_sourcemap) / COUNT(0) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    countSourcemaps(payload) > 0 AS has_sourcemap
  FROM
    `httparchive.pages.2021_07_01_*`)
GROUP BY
  client
