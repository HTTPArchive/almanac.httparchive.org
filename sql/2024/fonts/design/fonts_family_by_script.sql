-- Section: Design
-- Question: Which families are used broken down by script?
-- Normalization: Requests (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
requests AS (
  SELECT
    client,
    SCRIPTS(payload) AS scripts,
    FAMILY(payload) AS family,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
)

SELECT
  client,
  script,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  requests,
  UNNEST(scripts) AS script
WHERE
  family != 'Adobe Blank'
GROUP BY
  client,
  script,
  family,
  requests.total
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  proportion DESC
