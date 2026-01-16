-- Section: Development
-- Question: Which variable families are used?
-- Normalization: Requests (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
)

SELECT
  client,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  requests
GROUP BY
  client,
  family,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
