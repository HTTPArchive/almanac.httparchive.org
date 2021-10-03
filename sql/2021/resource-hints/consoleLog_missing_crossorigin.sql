#standardSQL
# returns the file types for preload tags without the required crossorigin attribute

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

# helper to convert the href into a type
CREATE TEMP FUNCTION GET_TYPE (href STRING) RETURNS STRING AS (
  IF(
    REGEXP_CONTAINS(href, r'fonts\.googleapis\.com'),
    "fonts.googleapis.com",
    TRIM(TRIM(REGEXP_EXTRACT(href, r'\.[0-9a-z]+(?:[\?#]|$)'), '?'), '#')
  )
);

SELECT
  client,
  GET_TYPE(TRIM(href, '\'')) AS type,
  COUNT(0) AS total,
  AS_PERCENT(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'A preload for (.+?) is found, but is not used because the request credentials mode does not match') AS value
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT(payload, "$._consoleLog") AS consoleLog
    FROM
      `httparchive.pages.2021_07_01_*`
    )
  WHERE
    consoleLog IS NOT NULL
)
CROSS JOIN UNNEST(value) AS href
WHERE
  ARRAY_LENGTH(value) > 0
GROUP BY
  client,
  type
ORDER BY
  client,
  total DESC
