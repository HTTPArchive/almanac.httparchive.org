-- Section: Performance
-- Question: Which file formats are used broken down by service?
-- Normalization: Links (primary) and fonts (secondary)

-- INCLUDE ../common.sql

WITH
links AS (
  SELECT
    client,
    url,
    SERVICE(url) AS service,
    FILE_FORMAT(
      JSON_EXTRACT_SCALAR(summary, '$.ext'),
      JSON_EXTRACT_SCALAR(summary, '$.mimeType')
    ) AS format,
    COUNT(0) OVER (PARTITION BY client) AS total,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total_secondary
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
)

SELECT
  client,
  service,
  format,
  COUNT(0) AS count,
  COUNT(DISTINCT url) AS count_secondary,
  total,
  total_secondary,
  COUNT(0) / total AS proportion,
  COUNT(DISTINCT url) / total_secondary AS proportion_secondary,
  ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(0) DESC) AS rank
FROM
  links
GROUP BY
  client,
  service,
  format,
  total,
  total_secondary
QUALIFY
  rank <= 10
ORDER BY
  client,
  service,
  proportion DESC
