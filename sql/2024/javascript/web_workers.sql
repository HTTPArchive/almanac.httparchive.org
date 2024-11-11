# standardSQL
# usage of web worker using blink features from usage counters
# web_workers.sql
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20240601' AND
  feature = 'WorkerStart'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
