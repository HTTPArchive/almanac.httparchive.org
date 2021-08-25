#standardSQL
# Calculates percentage of sites where the performance score changed small ( < 10), medium (10-30) or large (> 30) between LH 5 and 6 versions.
SELECT
  direction,
  magnitude,
  pages AS freq,
  SUM(pages) OVER () AS total,
  pages / SUM(pages) OVER () AS pct
FROM (
  SELECT
    CASE
      WHEN perf_score_delta < 0 THEN 'negative'
      ELSE 'positive'
    END AS direction,
    CASE
      WHEN ABS(perf_score_delta) <= 0.1 THEN 'small'
      WHEN ABS(perf_score_delta) < 0.3 THEN 'large'
      ELSE 'medium'
    END AS magnitude,
    COUNT(0) AS pages
  FROM (
    SELECT
      perf_score_lh6,
      perf_score_lh5,
      perf_score_lh6 - perf_score_lh5 AS perf_score_delta
    FROM (
      SELECT
        CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
        CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5
      FROM
        `httparchive.lighthouse.2020_09_01_mobile` AS lh6
      JOIN
        `httparchive.lighthouse.2019_07_01_mobile` AS lh5
      USING (url)))
  GROUP BY
    direction,
    magnitude)
