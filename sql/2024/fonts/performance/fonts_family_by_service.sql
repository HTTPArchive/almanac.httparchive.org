-- Section: Performance
-- Question: Which families are used broken down by service?

-- INCLUDE ../common.sql

SELECT
  client,
  SERVICE(url) AS service,
  FAMILY(payload) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font'
GROUP BY
  client,
  service,
  family
ORDER BY
  client,
  proportion DESC
