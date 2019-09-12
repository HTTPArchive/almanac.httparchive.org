#standardSQL
# 07_24: Percentiles of lighthouse performance score
#This metric comes from Lighthouse only
SELECT
  APPROX_QUANTILES(score, 1000)[OFFSET(100)] AS p10,
  APPROX_QUANTILES(score, 1000)[OFFSET(250)] AS p25,
  APPROX_QUANTILES(score, 1000)[OFFSET(500)] AS p50,
  APPROX_QUANTILES(score, 1000)[OFFSET(750)] AS p75,
  APPROX_QUANTILES(score, 1000)[OFFSET(900)] AS p90
FROM 
(
  SELECT 
     CAST(JSON_EXTRACT(report, '$.categories.performance.score') AS NUMERIC) AS score
  FROM 
     `httparchive.lighthouse.2019_07_01_mobile`
)
