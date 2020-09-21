#standardSQL
# Distribution of LH6 performance score.

SELECT
  SAFE_DIVIDE(slow,    slow + avg + fast + hundred) AS slow,
  SAFE_DIVIDE(avg,     slow + avg + fast + hundred) AS avg,
  SAFE_DIVIDE(fast,    slow + avg + fast + hundred) AS fast,
  SAFE_DIVIDE(hundred, slow + avg + fast + hundred) AS hundred
FROM (
  SELECT COUNTIF(score < 0.3) slow, COUNTIF(score > 0.3 and score < 0.8) avg, COUNTIF(score > 0.8 and score < 1.0) fast, COUNTIF(score = 1.0) hundred
  FROM (
    SELECT CAST(JSON_EXTRACT(report, '$.categories.performance.score') AS NUMERIC) score FROM `httparchive.lighthouse.2020_09_01_mobile`
  )
)