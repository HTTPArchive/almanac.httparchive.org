-- Section: Development
-- Question: Which variable families are used?
-- Normalization: Links

-- INCLUDE ../common.sql

SELECT
  client,
  FAMILY(payload) AS family,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-07-01' AND
  is_root_page AND
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
