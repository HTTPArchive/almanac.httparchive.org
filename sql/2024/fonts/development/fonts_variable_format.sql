-- Section: Development
-- Question: Which outline formats are used in variable fonts?

CREATE TEMPORARY FUNCTION IS_VARIABLE(json STRING) AS (
  REGEXP_CONTAINS(
    JSON_EXTRACT(json, '$._font_details.table_sizes'),
    '(?i)gvar|CFF2'
  )
);

CREATE TEMPORARY FUNCTION VARIABLE_FORMATS(json STRING) AS (
  REGEXP_EXTRACT_ALL(
    JSON_EXTRACT(json, '$._font_details.table_sizes'),
    '(?i)glyf|CFF2'
  )
);

WITH
fonts AS (
  SELECT
    client,
    url,
    format
  FROM
    `httparchive.all.requests`,
    UNNEST(VARIABLE_FORMATS(payload)) AS format
  WHERE
    date = '2024-06-01' AND
    type = 'font' AND
    IS_VARIABLE(payload)
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
