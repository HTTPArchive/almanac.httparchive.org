-- Section: Development
-- Question: Who is serving variable fonts?
-- Normalization: Links

-- INCLUDE ../common.sql

SELECT
  date,
  client,
  SERVICE(url) AS service,
  COUNT(0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY date, client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
  is_root_page AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  date,
  client,
  service
ORDER BY
  date,
  client,
  proportion DESC
