#standardSQL
# returns the number of unused preloaded resources

SELECT
  client,
  ARRAY_LENGTH(value) AS numOfUnusedPreloads,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT
    client,
    REGEXP_EXTRACT_ALL(consoleLog, r'The resource (.*?) was preloaded using link preload but not used within a few seconds from the window\'s load event') AS value
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
  numOfUnusedPreloads
ORDER BY
  client,
  numOfUnusedPreloads
