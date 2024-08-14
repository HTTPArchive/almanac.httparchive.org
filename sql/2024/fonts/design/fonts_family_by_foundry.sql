-- Section: Design
-- Question: Which families are used broken down by foundry?

-- INCLUDE ../common.sql

SELECT
  client,
  FOUNDRY(payload) AS foundry,
  FAMILY(payload) AS family,
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
  foundry,
  family
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
