-- Section: Design
-- Question: Which families are used broken down by foundry?
-- Normalization: Requests (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    FOUNDRY(payload) AS foundry,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    IS_PARSED(payload) AND
    is_root_page
)

SELECT
  client,
  foundry,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client ORDER BY COUNT(0) DESC) AS rank
FROM
  requests
GROUP BY
  client,
  foundry,
  family,
  total
QUALIFY
  rank <= 100
ORDER BY
  client,
  proportion DESC
