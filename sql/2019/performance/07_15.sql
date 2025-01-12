#standardSQL
# 07_15: Percentiles of first cpu idle
#This metric comes from Lighthouse
SELECT
  percentile,
  ROUND(APPROX_QUANTILES(first_cpu_idle, 1000)[OFFSET(percentile * 10)] / 1000, 2) AS first_cpu_idle
FROM (
  SELECT
    CAST(IFNULL(JSON_EXTRACT(report, '$.audits.first-interactive.numericValue'), JSON_EXTRACT(report, '$.audits.first-cpu-idle.numericValue')) AS FLOAT64) AS first_cpu_idle
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  percentile
ORDER BY
  percentile
