#standardSQL
# LH5 vs LH6 score. WIP

# Calculates minimum, maximum and average delta between LH5 and LH6 performance score
SELECT MIN(perf_score_delta) AS min_delta, MAX(perf_score_delta) AS max_delta, AVG(perf_score_delta) AS avg_delta
FROM
(
  SELECT
    url,
    perf_score_lh6,
    perf_score_lh5,
    (perf_score_lh6 - perf_score_lh5) as perf_score_delta
  FROM
  (
    SELECT lh6.url AS url,
      CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
      CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5,
      FROM `httparchive.sample_data.lighthouse_mobile_10k` lh6
      JOIN `httparchive.scratchspace.2020_03_01_lighthouse_mobile_10k` lh5 ON lh5.url=lh6.url
  )
)