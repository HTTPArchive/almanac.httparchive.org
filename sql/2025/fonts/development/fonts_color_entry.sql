-- Section: Development
-- Question: How many entries are there in color palettes?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    INT64(ANY_VALUE(payload)._font_details.color.numPaletteEntries) AS entries,
    COUNT(0) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = @date AND
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
  ROUND(COUNT(0) / total, @precision) AS proportion
FROM
  fonts
GROUP BY
  client,
  entries,
  total
ORDER BY
  client,
  count DESC
