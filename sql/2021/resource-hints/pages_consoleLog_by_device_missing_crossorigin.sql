#standardSQL
# returns the number of pages with preload tags without required crossorigin attribute

# helper to create percent fields
CREATE TEMP FUNCTION AS_PERCENT (freq FLOAT64, total FLOAT64) RETURNS FLOAT64 AS (
  ROUND(SAFE_DIVIDE(freq, total), 4)
);

SELECT
  client,
  COUNTIF(consoleLog LIKE '%A preload for % is found, but is not used because the request credentials mode does not match. Consider taking a look at crossorigin attribute.%') AS freq,
  COUNT(0) AS total,
  AS_PERCENT(COUNTIF(consoleLog LIKE '%A preload for % is found, but is not used because the request credentials mode does not match. Consider taking a look at crossorigin attribute.%'), SUM(COUNT(0)) OVER (PARTITION BY client)) AS pct_freq
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
