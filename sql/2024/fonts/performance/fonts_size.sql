-- Section: Performance
-- Question: What is the distribution of the file size?

WITH
fonts AS (
  SELECT
    client,
    url,
    AVG(PARSE_NUMERIC(JSON_EXTRACT_SCALAR(summary, '$.respBodySize'))) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  percentile,
  COUNT(DISTINCT url) AS count,
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
