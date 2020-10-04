#standardSQL

# Calculates percentage of sites where the performance score changed low ( < 10), medium (10-30) or big (> 30) between
# LH 5 and 6 versions.

SELECT
  SAFE_DIVIDE(small_change, small_change + mid_change + big_change) AS small,
  SAFE_DIVIDE(mid_change,   small_change + mid_change + big_change) AS avg,
  SAFE_DIVIDE(big_change,   small_change + mid_change + big_change) AS big
FROM (
  SELECT
    COUNTIF(perf_score_delta <= 0.1) AS small_change,
    COUNTIF(perf_score_delta > 0.1 AND perf_score_delta <= 0.3) AS mid_change,
    COUNTIF(perf_score_delta > 0.3) AS big_change
  FROM
  (
    SELECT
      perf_score_lh6,
      perf_score_lh5,
      (perf_score_lh6 - perf_score_lh5) AS perf_score_delta
    FROM
    (
      SELECT
        CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
        CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5
        FROM `httparchive.lighthouse.2020_09_01_mobile` lh6
        JOIN `httparchive.lighthouse.2020_05_01_mobile` lh5 ON lh5.url=lh6.url
    )
  )
)