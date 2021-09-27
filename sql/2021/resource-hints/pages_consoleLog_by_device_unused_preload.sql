#standardSQL
# returns the number of pages which preload unused resources

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
    client,
    COUNTIF(REGEXP_CONTAINS(consoleLog, r'The resource (.*) was preloaded using link preload but not used within a few seconds from the window\'s load event')) AS freq,
    COUNT(0) AS total,    
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT(payload, "$._consoleLog") AS consoleLog
  FROM
    `httparchive.pages.2021_07_01_*`
  )
WHERE
  consoleLog IS NOT NULL
GROUP BY
  client
ORDER BY
  client
