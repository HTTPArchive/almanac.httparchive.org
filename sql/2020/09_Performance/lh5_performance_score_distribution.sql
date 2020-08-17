#standardSQL
# Distribution of LH5 performance score.

SELECT
  SAFE_DIVIDE(slow,    slow + avg + fast + hundred) slow,
  SAFE_DIVIDE(avg,     slow + avg + fast + hundred) avg,
  SAFE_DIVIDE(fast,    slow + avg + fast + hundred) fast,
  SAFE_DIVIDE(hundred, slow + avg + fast + hundred) hundred,
FROM (
  SELECT COUNTIF(score < 0.3) slow, COUNTIF(score > 0.3 and score < 0.8) avg, COUNTIF(score > 0.8 and score < 1.0) fast, COUNTIF(score = 1.0) hundred
  FROM (
    SELECT CAST(JSON_EXTRACT(report, '$.categories.performance.score') AS NUMERIC) score FROM `httparchive.lighthouse.2020_05_01_mobile`
  )
)