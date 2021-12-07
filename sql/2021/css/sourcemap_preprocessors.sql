#standardSQL
# Adoption of preprocessors as a percent of pages that use sourcemaps.
CREATE TEMPORARY FUNCTION getSourcemappedExts(payload STRING) RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(payload);
  var sass = JSON.parse($._sass);
  return Object.keys(sass.sourcemaps.ext);
} catch (e) {
  return [];
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  ext,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getSourcemappedExts(payload)) AS ext
GROUP BY
  client,
  ext
ORDER BY
  pct DESC
