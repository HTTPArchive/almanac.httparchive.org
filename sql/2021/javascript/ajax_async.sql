# standardSQL
# usage of async XMLHttpRequest using blink features from usage counters
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage` WHERE
  feature = 'XMLHttpRequestAsynchronous' AND yyyymmdd = '20210701'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
