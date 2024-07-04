-- Section: Development
-- Question: Which color-font formats are used?

CREATE TEMPORARY FUNCTION COLOR_FORMATS(payload STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(payload, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)'
  )
);

SELECT
  client,
  format,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`,
  UNNEST(COLOR_FORMATS(payload)) AS format
WHERE
  date = '2024-06-01' AND
  type = 'font'
GROUP BY
  client,
  format
ORDER BY
  client,
  proportion DESC
