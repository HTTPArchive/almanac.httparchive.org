# standardSQL
# usage of web worker using blink features from usage counters

SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'WorkerStart'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
