-- Section: Development
-- Question: Which outline formats are used in variable fonts?
-- Normalization: Fonts (variable only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    VARIABLE_FORMATS(ANY_VALUE(payload)) AS formats,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
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
  format,
  COUNT(0) AS count,
  total,
  ROUND(COUNT(0) / total, @precision) AS proportion
FROM
  fonts,
  UNNEST(formats) AS format
GROUP BY
  date,
  client,
  format,
  total
ORDER BY
  date,
  client,
  proportion DESC
