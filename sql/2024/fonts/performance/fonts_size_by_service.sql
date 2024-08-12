-- Section: Performance
-- Question: What is the distribution of the file size broken down by service?

-- INCLUDE ../common.sql

WITH
services AS (
  SELECT
    client,
    SERVICE(url) AS service,
    url,
    AVG(PARSE_NUMERIC(JSON_EXTRACT_SCALAR(summary, '$.respBodySize'))) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    service,
    url
)

SELECT
  client,
  service,
  percentile,
  COUNT(DISTINCT url) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)]) AS size
FROM
  services,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
GROUP BY
  client,
  service,
  percentile
ORDER BY
  client,
  service,
  percentile
