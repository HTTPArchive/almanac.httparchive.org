-- Section: Development
-- Question: How popular are color fonts?
-- Normalization: Sites

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
  GROUP BY
    date,
    client
),
sites AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    is_root_page
  GROUP BY
    date,
    client
)

SELECT
  date,
  client,
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  sites USING (date, client)
ORDER BY
  date,
  proportion DESC
