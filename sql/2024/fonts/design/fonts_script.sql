-- Section: Design
-- Question: Which scripts does one design for?

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
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts,
  UNNEST(SCRIPTS(payload)) AS script
GROUP BY
  client,
  script
ORDER BY
  client,
  proportion DESC
