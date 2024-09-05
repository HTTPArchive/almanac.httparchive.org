-- Section: Performance
-- Question: Which file formats are used?
-- Normalization: Fonts on sites (primary) and sites (secondary)

-- INCLUDE ../common.sql

SELECT
  client,
  FILE_FORMAT(
    JSON_EXTRACT_SCALAR(summary, '$.ext'),
    JSON_EXTRACT_SCALAR(summary, '$.mimeType')
  ) AS format,
  COUNT(0) AS count,
  COUNT(DISTINCT url) AS count_secondary,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total_secondary,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion_secondary,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  is_root_page
GROUP BY
  client,
  format
QUALIFY
  rank <= 10
ORDER BY
  client,
  proportion DESC
