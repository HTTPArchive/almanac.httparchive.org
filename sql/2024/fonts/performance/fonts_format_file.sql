-- Section: Performance
-- Question: Which file formats are used?
-- Normalization: Fonts

-- INCLUDE ../common.sql

SELECT
  client,
  FILE_FORMAT(
    JSON_EXTRACT_SCALAR(summary, '$.ext'),
    JSON_EXTRACT_SCALAR(summary, '$.mimeType')
  ) AS format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS rank
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  format
QUALIFY
  rank <= 10
ORDER BY
  client,
  proportion DESC
