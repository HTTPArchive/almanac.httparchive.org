-- Section: Development
-- Question: How popular are color fonts?
-- Normalization: Sites

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font' AND
    IS_COLOR(payload)
  GROUP BY
    client
),
sites AS (
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
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  sites USING (client)
ORDER BY
  proportion DESC
