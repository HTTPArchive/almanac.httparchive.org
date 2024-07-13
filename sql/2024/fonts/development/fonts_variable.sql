-- Section: Development
-- Question: How popular are variable fonts?

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    IS_VARIABLE(payload)
  GROUP BY
    client
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
