-- Section: Performance
-- Question: Which families are used broken down by service?

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SERVICE(url) AS service,
    FAMILY(payload) AS family
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url,
    service,
    family
)

SELECT
  client,
  service,
  family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER(PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(0) DESC) AS rank
FROM
  fonts
GROUP BY
  client,
  service,
  family
QUALIFY
  rank <= 10
ORDER BY
  client,
  proportion DESC
