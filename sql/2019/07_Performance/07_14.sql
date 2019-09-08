#standardSQL
# 07_14: Percentiles of visually complete metric
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(visualComplete, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client
