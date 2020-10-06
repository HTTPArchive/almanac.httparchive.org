#standardSQL
# Percent of pages using Performance observer
  
SELECT
  client,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200901' AND
  feature = 'PerformanceObserverForWindow'