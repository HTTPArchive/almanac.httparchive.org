-- Section: Performance
-- Question: Which outline formats are used?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    REGEXP_EXTRACT_ALL(
      JSON_EXTRACT(
        ANY_VALUE(payload),
        '$._font_details.table_sizes'
      ),
      '(?i)(CFF |glyf|SVG|CFF2)'
    ) AS formats,
    COUNT(0) OVER (PARTITION BY date, client) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    type = 'font' AND
    is_root_page
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
