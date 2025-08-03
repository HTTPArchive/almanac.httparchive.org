-- Section: Development
-- Question: Which outline formats are used?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    REGEXP_EXTRACT_ALL(
      TO_JSON_STRING(ANY_VALUE(payload)._font_details.table_sizes),
      '(?i)(CFF |glyf|SVG|CFF2)'
    ) AS formats,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.crawl.requests`
  WHERE
    date IN UNNEST(@dates) AND
    type = 'font' AND
    is_root_page AND
    IS_PARSED(payload)
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
