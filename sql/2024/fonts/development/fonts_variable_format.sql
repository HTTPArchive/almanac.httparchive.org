-- Section: Development
-- Question: Which outline formats are used in variable fonts?

WITH
fonts AS (
  SELECT
    client,
    url,
    format
  FROM
    `httparchive.all.requests`,
    UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)glyf|CFF2')) AS format
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)gvar|CFF2')
  GROUP BY
    client,
    url,
    format
)

SELECT
  client,
  format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  fonts
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
