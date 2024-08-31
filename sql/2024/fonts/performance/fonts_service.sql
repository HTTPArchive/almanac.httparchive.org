-- Section: Performance
-- Question: Which services are popular?
-- Normalization: Pages

-- INCLUDE ../common.sql

WITH
pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01')
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  SERVICE(url) AS service,
  COUNT(DISTINCT page) AS count,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY date, client) AS total,
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY date, client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
  type = 'font'
GROUP BY
  date,
  client,
  service
ORDER BY
  date,
  client,
  proportion DESC
