-- Section: Design
-- Question: Which families are used broken down by foundry?

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(FOUNDRY(payload)) AS foundry,
    ANY_VALUE(FAMILY(payload)) AS family
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  foundry,
  family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT url) DESC) AS foundry_rank,
  ROW_NUMBER() OVER (PARTITION BY client, foundry ORDER BY COUNT(DISTINCT url) DESC) AS family_rank
FROM
  fonts
GROUP BY
  client,
  foundry,
  family
QUALIFY
  foundry_rank <= 100 AND
  family_rank <= 10
ORDER BY
  client,
  foundry,
  proportion DESC
