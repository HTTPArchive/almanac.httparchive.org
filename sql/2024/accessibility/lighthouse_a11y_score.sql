#standardSQL
# Percentiles of Lighthouse accessibility scores

WITH score_data AS (
  SELECT
    client,
    is_root_page,
    CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS FLOAT64) AS score
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    lighthouse IS NOT NULL AND
    lighthouse != '{}'
)

SELECT
  client,
  is_root_page,
  '2024_06_01' AS date,
  percentile,
  APPROX_QUANTILES(score, 1000)[OFFSET(percentile * 10)] AS score
FROM
  score_data,
  UNNEST([10, 25, 50, 75, 90]) AS percentile
GROUP BY
  client,
  is_root_page,
  percentile
ORDER BY
  client,
  is_root_page,
  percentile;
