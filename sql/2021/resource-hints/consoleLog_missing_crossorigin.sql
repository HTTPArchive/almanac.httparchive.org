#standardSQL
# returns the number of pages using preload tags without the required crossorigin attribute

SELECT
  client,
  ARRAY_LENGTH(value) AS numOfMissingCrossorigin,
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
      JSON_EXTRACT(payload, "$._consoleLog") AS consoleLog
    FROM
      `httparchive.pages.2021_07_01_*`
  )
)
GROUP BY
  client,
  numOfMissingCrossorigin
ORDER BY
  client,
  freq DESC
