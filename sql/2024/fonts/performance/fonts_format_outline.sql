-- Section: Performance
-- Question: Which outline formats are used?
-- Normalization: Fonts

WITH
fonts AS (
  SELECT
    client,
    url,
    JSON_EXTRACT(ANY_VALUE(payload), '$._font_details.table_sizes') AS payload
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-07-01' AND
    type = 'font'
  GROUP BY
    client,
    url
)

SELECT
  client,
  format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts,
  UNNEST(REGEXP_EXTRACT_ALL(payload, '(?i)(CFF |glyf|SVG|CFF2)')) AS format
GROUP BY
  client,
  format
ORDER BY
  proportion DESC
