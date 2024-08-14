-- Section: Design
-- Question: Which foundries are popular?

-- INCLUDE ../common.sql

WITH
foundries AS (
  SELECT
    client,
    FOUNDRY(payload) AS foundry,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    foundry
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01'
  GROUP BY
    client
)

SELECT
  client,
  foundry,
  count,
  total,
  count / total AS proportion
FROM
  foundries
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
LIMIT
  100
