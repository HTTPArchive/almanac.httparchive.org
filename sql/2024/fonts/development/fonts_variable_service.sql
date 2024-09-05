-- Section: Development
-- Question: Who is serving variable fonts?
-- Normalization: Fonts on sites

-- INCLUDE ../common.sql

SELECT
  client,
  SERVICE(url) AS service,
  COUNT(0) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  is_root_page AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  client,
  service
ORDER BY
  client,
  proportion DESC
