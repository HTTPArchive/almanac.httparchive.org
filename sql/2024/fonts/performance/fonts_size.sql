-- Section: Performance
-- Question: What is the distribution of the file size?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    client,
    url,
    PARSE_NUMERIC(JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.respBodySize')) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  percentile,
  COUNT(0) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)]) AS size
FROM
  fonts,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  percentile
ORDER BY
  client,
  percentile
