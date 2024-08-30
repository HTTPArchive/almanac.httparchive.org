-- Section: Performance
-- Question: Which file formats are used broken down by service?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SERVICE(url) AS service,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(summary, '$.ext'),
      JSON_EXTRACT_SCALAR(summary, '$.mimeType')
    ) AS format
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    service,
    format
)

SELECT
  client,
  service,
  format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(DISTINCT url) DESC) AS rank
FROM
  fonts
GROUP BY
  client,
  service,
  format
QUALIFY
  rank <= 10
ORDER BY
  client,
  service,
  proportion DESC
