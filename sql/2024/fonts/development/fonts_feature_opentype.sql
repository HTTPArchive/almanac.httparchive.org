-- Section: Development
-- Question: How prevalent is OpenType support?
-- Normalization: Fonts (parsed only)

-- INCLUDE https://github.com/HTTPArchive/almanac.httparchive.org/blob/main/sql/2024/fonts/common.sql

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    REGEXP_CONTAINS(
      JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes'),
      '(?i)GPOS|GSUB'
    ) AS support,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND -- noqa: CV09
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
