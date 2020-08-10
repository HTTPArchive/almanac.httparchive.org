#standardSQL
# Doctype M101

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

CREATE TEMPORARY FUNCTION normalise(content STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  // trim
  // lower case

  return content.trim().toLowerCase().replace(/ +/g, " ");
} catch (e) {
  return '';
}
''';

SELECT
  _TABLE_SUFFIX AS client,
  normalise(doctype) AS doctype,
  COUNT(0) AS freq,
  # SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct
FROM
  `httparchive.sample_data.summary_pages_*`
GROUP BY
  client,
  doctype
ORDER BY
  freq DESC,
  client
LIMIT
  100
