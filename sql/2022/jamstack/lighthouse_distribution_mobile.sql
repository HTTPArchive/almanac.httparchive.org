-- getting buckets of performance scores to find median
WITH performance_scores AS (
  SELECT
    url,
    CAST(JSON_EXTRACT(payload, "$['_lighthouse.Performance']") AS NUMERIC) AS performance_score
  FROM `httparchive.pages.2022_06_01_mobile`
)

SELECT
  round(performance_score, 2) AS perf_rounded,
  count(distinct(url)) AS urls
FROM performance_scores
WHERE performance_score IS NOT NULL
GROUP BY perf_rounded
ORDER BY perf_rounded
