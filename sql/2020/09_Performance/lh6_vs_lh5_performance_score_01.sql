#standardSQL

# Calculates minimum, maximum and average delta between LH5 and LH6 performance score for mobile
SELECT MIN(perf_score_delta) AS min_delta, MAX(perf_score_delta) AS max_delta, AVG(abs_perf_score_delta) AS avg_delta
FROM
(
  SELECT
    url,
    perf_score_lh6,
    perf_score_lh5,
    (perf_score_lh6 - perf_score_lh5) as perf_score_delta,
    ABS(perf_score_lh6 - perf_score_lh5) as abs_perf_score_delta,
  FROM
  (
    SELECT lh6.url AS url,
      CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
      CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5,
      FROM `httparchive.lighthouse.2020_08_01_mobile` lh6
      JOIN `httparchive.lighthouse.2020_05_01_mobile` lh5 ON lh5.url=lh6.url
  )
)