-- Section: Performance
-- Question: Which outline formats are used?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    date,
    client,
    url,
    COUNT(0) OVER (PARTITION BY date, client) AS total,
    JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes') AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date IN ('2022-07-01', '2023-07-01', '2024-07-01') AND
    is_root_page AND
    type = 'font'
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
  UNNEST(REGEXP_EXTRACT_ALL(payload, '(?i)(CFF |glyf|SVG|CFF2)')) AS format
GROUP BY
  date,
  client,
  format,
  total
ORDER BY
  date,
  client,
  proportion DESC
