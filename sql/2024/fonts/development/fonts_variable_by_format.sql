-- Section: Development
-- Question: How widespread are the two outline formats of variable fonts?

WITH
fonts AS (
  SELECT
    client,
    format,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`,
    UNNEST(REGEXP_EXTRACT_ALL(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)glyf|CFF2')) AS format
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._font_details.table_sizes'), '(?i)gvar|CFF2'))
  GROUP BY
    client,
    format
),
pages AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  format,
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  pages USING (client)
ORDER BY
  client,
  proportion DESC
