#standardSQL
# 07_16: Percentiles of time to interactive
#This metric comes from Lighthouse
SELECT
  percentile,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS tti
FROM (
  SELECT
    CAST(IFNULL(JSON_EXTRACT(report, '$.audits.consistently-interactive.numericValue'), JSON_EXTRACT(report, '$.audits.interactive.numericValue')) AS FLOAT64) AS tti
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
