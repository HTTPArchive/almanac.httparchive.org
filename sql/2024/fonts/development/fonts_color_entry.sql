-- Section: Development
-- Question: How many entries are there in color palettes?
-- Normalization: Fonts (color only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    client,
    url,
    SAFE_CAST(
      JSON_EXTRACT_SCALAR(
        ANY_VALUE(payload),
        '$._font_details.color.numPaletteEntries'
      ) AS INT64
    ) AS entries,
    COUNT(0) OVER (PARTITION BY client) AS total
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
