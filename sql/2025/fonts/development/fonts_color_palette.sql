-- Section: Development
-- Question: How many palettes are there in color fonts?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2025/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    INT64(ANY_VALUE(payload)._font_details.color.numPalettes) AS entries,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND
    type = 'font' AND
    is_root_page AND
    IS_COLOR(payload)
  GROUP BY
    client,
    url
)

SELECT
  client,
  entries,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  fonts
GROUP BY
  client,
  entries,
  total
ORDER BY
  client,
  proportion DESC
