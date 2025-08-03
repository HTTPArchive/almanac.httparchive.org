-- Section: Development
-- Question: How prevalent is OpenType support?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/{year}/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    REGEXP_CONTAINS(
      TO_JSON_STRING(ANY_VALUE(payload)._font_details.table_sizes),
      '(?i)GPOS|GSUB'
    ) AS support,
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
  support,
  COUNT(0) AS count,
  total,
  COUNT(0) / total AS proportion
FROM
  fonts
GROUP BY
  date,
  client,
  support,
  total
ORDER BY
  date,
  client,
  support
