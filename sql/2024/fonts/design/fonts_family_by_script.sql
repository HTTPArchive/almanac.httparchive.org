-- Section: Design
-- Question: Which families are used broken down by script?

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(payload) AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  script,
  FAMILY(payload) AS family,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion,
  ROW_NUMBER() OVER (PARTITION BY client, script ORDER BY COUNT(0) DESC) AS rank
FROM
  fonts,
  UNNEST(SCRIPTS(payload)) AS script
GROUP BY
  client,
  script,
  family
QUALIFY
  rank <= 10
ORDER BY
  client,
  script,
  proportion DESC
