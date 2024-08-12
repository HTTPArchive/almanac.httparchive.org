-- Section: Performance
-- Question: Which file formats are used?

-- INCLUDE ../common.sql

SELECT
  client,
  FILE_FORMAT(
    JSON_VALUE(summary, '$.ext'),
    JSON_VALUE(summary, '$.mimeType')
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
  format
ORDER BY
  client,
  proportion DESC
