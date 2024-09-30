-- Section: Development
-- Question: Which color families are used?
-- Normalization: Links (color only)

-- INCLUDE ../common.sql

WITH
links AS (
  SELECT
    client,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
)

SELECT
  client,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  links
GROUP BY
  client,
  family,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
