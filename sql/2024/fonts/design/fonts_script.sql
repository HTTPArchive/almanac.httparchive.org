-- Section: Design
-- Question: Which scripts does one design for?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    ANY_VALUE(payload) AS payload,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    is_root_page
  GROUP BY
    client,
    url
)

SELECT
  client,
  script,
  COUNT(DISTINCT url) AS count,
  total,
  COUNT(DISTINCT url) / total AS proportion
FROM
  fonts,
  UNNEST(SCRIPTS(payload)) AS script
GROUP BY
  client,
  script,
  total
ORDER BY
  client,
  proportion DESC
