-- Section: Development
-- Question: Which variable families are used?

-- INCLUDE ../common.sql

SELECT
  client,
  FAMILY(payload) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS rank
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  type = 'font' AND
  IS_VARIABLE(payload)
GROUP BY
  client,
  family
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
