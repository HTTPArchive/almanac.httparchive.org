#standardSQL
# 07_16: Percentiles of time to interactive
#This metric comes from Lighthouse
SELECT
   _TABLE_SUFFIX AS client,
  ROUND(APPROX_QUANTILES(CAST(IFNULL(JSON_EXTRACT(report, "$.audits.consistently-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.interactive.numericValue")) AS FLOAT64), 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(CAST(IFNULL(JSON_EXTRACT(report, "$.audits.consistently-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.interactive.numericValue")) AS FLOAT64), 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(CAST(IFNULL(JSON_EXTRACT(report, "$.audits.consistently-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.interactive.numericValue")) AS FLOAT64), 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(CAST(IFNULL(JSON_EXTRACT(report, "$.audits.consistently-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.interactive.numericValue")) AS FLOAT64), 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(CAST(IFNULL(JSON_EXTRACT(report, "$.audits.consistently-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.interactive.numericValue")) AS FLOAT64), 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM
  `httparchive.lighthouse.2019_07_01_*`
GROUP BY
  client
