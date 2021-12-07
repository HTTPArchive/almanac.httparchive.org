#standardSQL
# Viewport M219

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION normalise(content STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  // split by ,
  // trim
  // lower case
  // alphabetize
  // re join by comma

  return content.split(",").map(c1 => c1.trim().toLowerCase().replace(/ +/g, "").replace(/\\.0*/,"")).sort().join(",");
} catch (e) {
  return '';
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  normalise(meta_viewport) AS meta_viewport,
  COUNT(0) AS freq,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m219
FROM
  `httparchive.summary_pages.2020_08_01_*`
GROUP BY
  client,
  meta_viewport
ORDER BY
  freq DESC,
  client
LIMIT 100
