-- Section: Performance
-- Question: Which file formats are used broken down by service?

-- INCLUDE ../common.sql

SELECT
  client,
  SERVICE(url) AS service,
  FILE_FORMAT(url, header.value) AS format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(response_headers) AS header
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  LOWER(header.name) = 'content-type' AND
  TRIM(header.value) != ''
GROUP BY
  client,
  service,
  format
ORDER BY
  client,
  service,
  proportion DESC
