#standardSQL
# returns the file types for preload tags without the required crossorigin attribute

# helper to convert the href into a type
CREATE TEMPORARY FUNCTION getType(href STRING) RETURNS STRING AS (
  IF(
    REGEXP_CONTAINS(href, r'fonts\.googleapis\.com'),
    'fonts.googleapis.com',
    TRIM(TRIM(REGEXP_EXTRACT(href, r'\.[0-9a-z]+(?:[\?#]|$)'), '?'), '#')
  )
);

SELECT
  client,
  getType(TRIM(href, "'")) AS type,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'A preload for (.+?) is found, but is not used because the request credentials mode does not match') AS value
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT(payload, '$._consoleLog') AS consoleLog
    FROM
      `httparchive.pages.2021_07_01_*`
  )
)
CROSS JOIN UNNEST(value) AS href
GROUP BY
  client,
  type
ORDER BY
  client,
  freq DESC
