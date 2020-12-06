#standardSQL
SELECT
  perf_score_delta,
  COUNT(0) AS pages
FROM (
  SELECT
    perf_score_lh6 - perf_score_lh5 AS perf_score_delta,
    ROW_NUMBER() OVER (ORDER BY (perf_score_lh6 - perf_score_lh5)) AS row_number,
    COUNT(0) OVER () AS n
  FROM (
    SELECT
      CAST(JSON_EXTRACT(lh6.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh6,
      CAST(JSON_EXTRACT(lh5.report, '$.categories.performance.score') AS NUMERIC) AS perf_score_lh5
    FROM
      `httparchive.lighthouse.2020_09_01_mobile` AS lh6
    JOIN
      `httparchive.lighthouse.2019_07_01_mobile` AS lh5
    USING (url)))
WHERE
  perf_score_delta IS NOT NULL
GROUP BY
  perf_score_delta
ORDER BY
  perf_score_delta
