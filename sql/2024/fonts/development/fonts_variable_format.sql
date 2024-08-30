-- Section: Development
-- Question: Which outline formats are used in variable fonts?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    format
  FROM
    `httparchive.all.requests`,
    UNNEST(VARIABLE_FORMATS(payload)) AS format
  WHERE
    date = '2024-07-01' AND
    type = 'font' AND
    IS_VARIABLE(payload)
  GROUP BY
    client,
    url,
    format
)

SELECT
  client,
  format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
