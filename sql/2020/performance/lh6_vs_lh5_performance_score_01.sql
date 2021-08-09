#standardSQL
# Calculates percentile for delta of LH5 and LH6 performance score for mobile

SELECT
  percentile,
  APPROX_QUANTILES(perf_score_delta, 1000)[OFFSET(percentile * 10)] AS perf_score_delta
FROM (
  SELECT
    perf_score_lh6 - perf_score_lh5 AS perf_score_delta
  FROM
  (
    SELECT
      CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
      CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5
    FROM `httparchive.lighthouse.2020_09_01_mobile` lh6
    JOIN `httparchive.lighthouse.2019_07_01_mobile` lh5 ON lh5.url = lh6.url
  )
),
UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY percentile
ORDER BY percentile
