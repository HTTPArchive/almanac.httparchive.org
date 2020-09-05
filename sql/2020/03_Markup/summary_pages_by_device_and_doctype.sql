#standardSQL
# Doctype M101

CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  _TABLE_SUFFIX AS client,
  LOWER(REGEXP_REPLACE(TRIM(doctype), r" +", " ")) AS doctype, # remove extra spaces and make lower case
  COUNT(0) AS freq,
  # SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX)) AS pct_m101
FROM
  #`httparchive.sample_data.summary_pages_*` # TEST
  `httparchive.summary_pages.2020_08_01_*` # LIVE
GROUP BY
  client,
  doctype
ORDER BY
  freq DESC,
  client
LIMIT
  100
