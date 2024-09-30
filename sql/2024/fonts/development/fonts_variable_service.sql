-- Section: Development
-- Question: Who is serving variable fonts?
-- Normalization: Fonts (only variable)

-- INCLUDE ../common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    SERVICE(url) AS service,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    type = 'font' AND
    is_root_page AND
    IS_VARIABLE(payload)
  GROUP BY
    date,
    client,
    url
)

SELECT
  date,
  client,
  service,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  fonts
GROUP BY
  date,
  client,
  service,
  total
ORDER BY
  date,
  client,
  proportion DESC
