-- Section: Development
-- Question: Who is serving variable fonts?

-- INCLUDE ../common.sql

SELECT
  client,
  SERVICE(url) AS service,
  COUNT(DISTINCT url) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  client,
  service
ORDER BY
  client,
  proportion DESC
