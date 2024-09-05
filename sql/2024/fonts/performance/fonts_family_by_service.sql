-- Section: Performance
-- Question: Which families are used broken down by service?
-- Normalization: Fonts on sites

-- INCLUDE ../common.sql

WITH
requests AS (
  SELECT
    client,
    SERVICE(url) AS service,
    FAMILY(payload) AS family
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
)

SELECT
  client,
  service,
  family,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(0) DESC) AS rank
FROM
  requests
GROUP BY
  client,
  service,
  family
QUALIFY
  rank <= 10
ORDER BY
  client,
  service,
  proportion DESC
