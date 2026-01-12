-- Section: Development
-- Question: Which color formats are used broken down by family?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    COLOR_FORMATS(ANY_VALUE(payload)) AS formats,
    FAMILY(ANY_VALUE(payload)) AS family,
    COUNT(DISTINCT url) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND -- noqa: CV09
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  format,
  family,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion,
  ANY_VALUE(url) AS example
FROM
  fonts,
  UNNEST(formats) AS format
GROUP BY
  client,
  format,
  family,
  total
ORDER BY
  client,
  format,
  proportion DESC
