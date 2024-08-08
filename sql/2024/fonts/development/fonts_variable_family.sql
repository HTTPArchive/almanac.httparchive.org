-- Section: Development
-- Question: Which color families are used?

-- INCLUDE ../common.sql

SELECT
  client,
  FAMILY(payload) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  client,
  family
ORDER BY
  client,
  proportion DESC
