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
  DISTINCT _TABLE_SUFFIX AS client,
  ext,
  COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX, ext) AS freq,
  COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX, ext) / COUNT(DISTINCT url) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.pages.2020_08_01_*`,
  UNNEST(getSourcemappedExts(payload)) AS ext
ORDER BY
  pct DESC