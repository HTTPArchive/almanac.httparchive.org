-- Section: Performance
-- Question: Which file formats are used broken down by service?

-- INCLUDE ../common.sql

SELECT
  client,
  SERVICE(url) AS service,
  FILE_FORMAT(
    JSON_EXTRACT_SCALAR(summary, '$.ext'),
    JSON_EXTRACT_SCALAR(summary, '$.mimeType')
  ) AS format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  service,
  format
ORDER BY
  client,
  service,
  proportion DESC
