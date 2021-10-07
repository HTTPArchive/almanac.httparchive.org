#standardSQL
# returns the number of pages which preload a resource of the incorrect script type

SELECT
  client,
  ARRAY_LENGTH(value) AS numOfIncorrectType,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
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
)
GROUP BY
  client,
  numOfIncorrectType
ORDER BY
  client,
  numOfIncorrectType
