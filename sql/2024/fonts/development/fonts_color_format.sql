-- Section: Development
-- Question: Which color-font formats are used?
-- Normalization: Fonts

-- INCLUDE ../common.sql

SELECT
  client,
  format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(COLOR_FORMATS(payload)) AS format
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
