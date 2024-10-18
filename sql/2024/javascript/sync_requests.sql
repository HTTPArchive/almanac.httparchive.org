# standardSQL
# usage of synchronous XMLHttpRequest using blink features from usage counters
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20240601' AND
  feature = 'XMLHttpRequestSynchronous'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
