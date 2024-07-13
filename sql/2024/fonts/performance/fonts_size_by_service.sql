-- Section: Performance
-- Question: What is the distribution of the file size broken down by service?

-- INCLUDE ../common.sql

WITH
services AS (
  SELECT
    client,
    SERVICE(url) AS service,
    url,
    AVG(PARSE_NUMERIC(header.value)) AS size
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) AS header
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    LOWER(header.name) = 'content-length' AND
    TRIM(header.value) != ''
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
  APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)] AS size
FROM
  services,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  service,
  percentile
ORDER BY
  client,
  service,
  percentile
