-- Section: Design
-- Question: Which scripts does one design for?
-- Normalization: Fonts

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
    date = '2024-07-01' AND
    is_root_page AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  script,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  fonts,
  UNNEST(SCRIPTS(payload)) AS script
GROUP BY
  client,
  script
ORDER BY
  client,
  proportion DESC
