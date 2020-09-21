#standardSQL
# Distribution of LH5 performance score.

SELECT
  SAFE_DIVIDE(slow,    slow + avg + fast + hundred) AS slow,
  SAFE_DIVIDE(avg,     slow + avg + fast + hundred) AS avg,
  SAFE_DIVIDE(fast,    slow + avg + fast + hundred) AS fast,
  SAFE_DIVIDE(hundred, slow + avg + fast + hundred) AS hundred,
FROM (
  SELECT
    COUNTIF(score < 0.3) AS slow,
    COUNTIF(score > 0.3 AND score < 0.8) AS avg,
    COUNTIF(score > 0.8 AND score < 1.0) AS fast,
    COUNTIF(score = 1.0) AS hundred
  FROM (
    SELECT CAST(JSON_EXTRACT(report, '$.categories.performance.score') AS NUMERIC) score FROM `httparchive.lighthouse.2020_05_01_mobile`
  )
)
