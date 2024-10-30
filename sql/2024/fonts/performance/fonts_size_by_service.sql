-- Section: Performance
-- Question: What is the distribution of the file size broken down by service?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SERVICE(url) AS service,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.ext'),
      JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.mimeType')
    ) AS format,
    PARSE_NUMERIC(JSON_EXTRACT_SCALAR(ANY_VALUE(summary), '$.respBodySize')) AS size
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
  GROUP BY
    client,
    url
),
formats AS (
  SELECT
    client,
    service,
    format,
    ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(DISTINCT url) DESC) AS rank
  FROM
    fonts
  GROUP BY
    client,
    service,
    format
)

SELECT
  client,
  service,
  format,
  percentile,
  COUNT(DISTINCT url) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)]) AS size
FROM
  fonts,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
INNER JOIN
  formats USING (client, service, format)
WHERE
  rank <= 10
GROUP BY
  client,
  service,
  format,
  rank,
  percentile
ORDER BY
  client,
  service,
  rank,
  percentile
