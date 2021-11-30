# standardSQL
# usage of async XMLHttpRequest using blink features from usage counters
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'XMLHttpRequestAsynchronous'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
