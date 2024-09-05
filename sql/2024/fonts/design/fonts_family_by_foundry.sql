-- Section: Design
-- Question: Which families are used broken down by foundry?
-- Normalization: Fonts on sites

-- INCLUDE ../common.sql

SELECT
  client,
  FOUNDRY(payload) AS foundry,
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
