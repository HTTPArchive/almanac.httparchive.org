-- Section: Development
-- Question: How widespread are color fonts?

CREATE TEMPORARY FUNCTION COLOR_FORMATS(json STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(json, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|SVG|COLRv0|COLRv1)'
  )
);

WITH
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
),
fonts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS count
  FROM
    `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    ARRAY_LENGTH(COLOR_FORMATS(payload)) > 0
  GROUP BY
    client
)

SELECT
  client,
  count,
  total,
  count / total AS proportion
FROM
  fonts
JOIN
  pages USING (client)
ORDER BY
  proportion DESC
