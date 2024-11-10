# standardSQL
# usage of PostTask API using blink features from usage counters
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20240601' AND
  feature = 'SchedulerPostTask'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
