-- Section: Performance
-- Question: Which families are used broken down by service?
-- Normalization: Links (parsed only)

-- INCLUDE ../common.sql

WITH
links AS (
  SELECT
    client,
    SERVICE(url) AS service,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
)

SELECT
  client,
  service,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, service ORDER BY COUNT(0) DESC) AS rank
FROM
  links
GROUP BY
  client,
  service,
  family,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  service,
  proportion DESC
