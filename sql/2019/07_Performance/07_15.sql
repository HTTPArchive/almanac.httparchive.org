#standardSQL
# 07_15: Percentiles of first cpu idle
#This metric comes from Lighthouse
SELECT
  client,
  ROUND(APPROX_QUANTILES(firstCpuIdle, 1000)[OFFSET(100)] / 1000, 2) AS p10,
  ROUND(APPROX_QUANTILES(firstCpuIdle, 1000)[OFFSET(250)] / 1000, 2) AS p25,
  ROUND(APPROX_QUANTILES(firstCpuIdle, 1000)[OFFSET(500)] / 1000, 2) AS p50,
  ROUND(APPROX_QUANTILES(firstCpuIdle, 1000)[OFFSET(750)] / 1000, 2) AS p75,
  ROUND(APPROX_QUANTILES(firstCpuIdle, 1000)[OFFSET(900)] / 1000, 2) AS p90
FROM 
(
  SELECT
    _TABLE_SUFFIX AS client,
    CAST(IFNULL(JSON_EXTRACT(report, "$.audits.first-interactive.numericValue"), JSON_EXTRACT(report, "$.audits.first-cpu-idle.numericValue")) AS FLOAT64) AS firstCpuIdle
  FROM
    `httparchive.lighthouse.2019_07_01_*`
)
GROUP BY
  client
