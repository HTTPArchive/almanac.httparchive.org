-- Section: Performance
-- Question: Which services are popular?

-- INCLUDE ../common.sql

WITH
pages AS (
  SELECT
    date,
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date BETWEEN '2019-01-01' AND '2024-07-01'
  GROUP BY
    date,
    client
),
services AS (
  SELECT
    date,
    client,
    SERVICE(url) AS service,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date BETWEEN '2019-01-01' AND '2024-07-01' AND
    type = 'font'
  GROUP BY
    date,
    client,
    service
)

SELECT
  date,
  client,
  service,
  count,
  total,
  count / total AS proportion
FROM
  services
JOIN
  pages USING (date, client)
ORDER BY
  date,
  client,
  proportion DESC
