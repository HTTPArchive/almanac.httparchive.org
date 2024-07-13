-- Section: Design
-- Question: Which families are used broken down by foundry?

-- INCLUDE ../common.sql

SELECT
  client,
  FOUNDRY(payload) AS foundry,
  FAMILY(payload) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font'
GROUP BY
  client,
  foundry,
  family
ORDER BY
  client,
  proportion DESC
