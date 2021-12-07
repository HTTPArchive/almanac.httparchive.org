#standardSQL
# 07_24: Percentiles of lighthouse performance score
#This metric comes from Lighthouse only
SELECT
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] AS score
FROM (
  SELECT
    CAST(JSON_EXTRACT(report, '$.categories.performance.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
