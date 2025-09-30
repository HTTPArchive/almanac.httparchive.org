#standardSQL
# Percentiles of Lighthouse accessibility scores using exact sorting

WITH score_data AS (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS score
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    lighthouse.categories IS NOT NULL
),

sorted_scores AS (
  SELECT
    client,
    is_root_page,
    score,
    ROW_NUMBER() OVER (PARTITION BY client, is_root_page ORDER BY score ASC) AS rank,
    COUNT(0) OVER (PARTITION BY client, is_root_page) AS total_count
  FROM
    score_data
),

percentiles AS (
  SELECT
    client,
    is_root_page,
    rank,
    total_count,
    (rank - 1) / total_count AS percentile_value,
    score
  FROM
    sorted_scores
)

SELECT
  client,
  is_root_page,
  '2025_07_01' AS date,
  percentile,
  AVG(score) AS exact_score  -- Average score for each percentile
FROM
  percentiles,
  UNNEST([0.1, 0.25, 0.5, 0.75, 0.9]) AS percentile  -- Target percentiles (e.g., 10th, 25th, 50th, etc.)
WHERE
  ABS(percentile_value - percentile) < 0.01  -- Match scores around the percentile value
GROUP BY
  client,
  is_root_page,
  percentile
ORDER BY
  client,
  is_root_page,
  percentile;
