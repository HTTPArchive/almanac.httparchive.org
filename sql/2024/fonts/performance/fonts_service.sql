-- Section: Performance
-- Question: Which services are popular?

-- INCLUDE ../common.sql

WITH
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
),
services AS (
  SELECT
    client,
    SERVICE(url) AS service,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    service
)

SELECT
  client,
  service,
  count,
  total,
  count / total AS proportion
FROM
  services
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
