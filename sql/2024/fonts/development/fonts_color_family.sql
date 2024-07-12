-- Section: Development
-- Question: Which color families are used?

CREATE TEMPORARY FUNCTION COLOR_FORMATS(json STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(json, '$._font_details.color.formats'),
    '(?i)(sbix|CBDT|COLRv0|COLRv1|SVG)'
  )
);

CREATE TEMPORARY FUNCTION NAME(value STRING) AS (
  IF(LENGTH(TRIM(value)) < 3, NULL, NULLIF(TRIM(value), ''))
);

SELECT
  client,
  NAME(JSON_EXTRACT_SCALAR(payload, '$._font_details.names[1]')) AS family,
  COUNT(DISTINCT url) AS count,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  COUNT(DISTINCT url) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS proportion
FROM
  `httparchive.all.requests`
WHERE
  date = '2024-06-01' AND
  type = 'font' AND
  ARRAY_LENGTH(COLOR_FORMATS(payload)) > 0
GROUP BY
  client,
  family
ORDER BY
  client,
  proportion DESC
