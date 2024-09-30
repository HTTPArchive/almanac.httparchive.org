-- Section: Performance
-- Question: Which service combinations are popular?
-- Normalization: Sites

-- INCLUDE ../common.sql

WITH
services_1 AS (
  SELECT
    date,
    client,
    page,
    STRING_AGG(DISTINCT SERVICE(url), ', ' ORDER BY SERVICE(url)) AS services
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    type = 'font' AND
    is_root_page
  GROUP BY
    date,
    client,
    page
),
services_2 AS (
  SELECT
    date,
    client,
    services,
    COUNT(DISTINCT page) AS count
  FROM
    services_1
  GROUP BY
    date,
    client,
    services
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
  services,
  count,
  total,
  count / total AS proportion
FROM
  services_2
JOIN
  sites USING (date, client)
ORDER BY
  date,
  client,
  proportion DESC
