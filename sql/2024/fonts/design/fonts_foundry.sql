-- Section: Design
-- Question: Which foundries are popular?
-- Normalization: Sites

-- INCLUDE ../common.sql

WITH
foundries AS (
  SELECT
    client,
    FOUNDRY(payload) AS foundry,
    COUNT(DISTINCT page) AS count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(DISTINCT page) DESC) AS rank
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
  GROUP BY
    client,
    foundry
  QUALIFY
    rank <= 100
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page
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
