#standardSQL
# returns the number of pages which preload a resource of the incorrect script type

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  client,
  ARRAY_LENGTH(value) AS freq,
  COUNT(0) AS total
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'A preload for (.*?) is found, but is not used because the script type does not match.') AS value
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
WHERE
  ARRAY_LENGTH(value) > 0
GROUP BY
  client,
  freq
ORDER BY
  client,
  freq
