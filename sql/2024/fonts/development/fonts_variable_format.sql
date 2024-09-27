-- Section: Development
-- Question: Which outline formats are used in variable fonts?
-- Normalization: Fonts

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    format
  FROM
    `httparchive.all.requests`,
    UNNEST(VARIABLE_FORMATS(payload)) AS format
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    is_root_page AND
    type = 'font' AND
    IS_VARIABLE(payload)
  GROUP BY
    date,
    client,
    url,
    format
)

SELECT
  date,
  client,
  format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY date, client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY date, client) AS proportion
FROM
  fonts
GROUP BY
  date,
  client,
  format
ORDER BY
  date,
  client,
  proportion DESC
