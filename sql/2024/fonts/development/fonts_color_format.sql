-- Section: Development
-- Question: Which color formats are used?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    COLOR_FORMATS(ANY_VALUE(payload)) AS formats,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
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
  COUNT(0) / total AS proportion
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
