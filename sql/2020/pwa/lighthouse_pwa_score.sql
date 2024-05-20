#standardSQL
# Percentiles of lighthouse pwa score
# Based on 07_24: Percentiles of lighthouse performance score
# This metric comes from Lighthouse only and is only available in mobile in HTTP Archive dataset
SELECT
  '2019_07_01' AS date,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] AS score
FROM (
  SELECT
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  date,
  percentile
UNION ALL
SELECT
  '2020_08_01' AS date,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] AS score
FROM (
  SELECT
    CAST(JSON_EXTRACT(report, '$.categories.pwa.score') AS NUMERIC) AS score
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
),
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  date,
  percentile
ORDER BY
  date,
  percentile
