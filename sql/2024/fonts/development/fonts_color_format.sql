-- Section: Development
-- Question: Which color-font formats are used?

CREATE TEMPORARY FUNCTION COLOR_FORMATS(json STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(json, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|COLRv0|COLRv1|SVG)'
  )
);

SELECT
  client,
  format,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
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
