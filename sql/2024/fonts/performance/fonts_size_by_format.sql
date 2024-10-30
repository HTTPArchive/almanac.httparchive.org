-- Section: Performance
-- Question: What is the distribution of the file size broken down by format?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
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
    is_root_page
  GROUP BY
    client,
    url
),
formats AS (
  SELECT
    client,
    format,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS rank
  FROM
    fonts
  GROUP BY
    client,
    format
)

SELECT
  client,
  format,
  percentile,
  COUNT(DISTINCT url) AS count,
  ROUND(APPROX_QUANTILES(size, 1000)[OFFSET(percentile * 10)]) AS size
FROM
  fonts,
  UNNEST([10, 25, 50, 75, 90, 99]) AS percentile
INNER JOIN
  formats USING (client, format)
WHERE
  rank <= 10
GROUP BY
  client,
  format,
  rank,
  percentile
ORDER BY
  client,
  rank,
  percentile
