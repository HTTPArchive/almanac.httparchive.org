#standardSQL
# Percent of pages using Performance observer

SELECT
  client,
  num_urls AS pages_with_performance_observer,
  total_urls AS total_pages,
  pct_urls AS pct_pages_with_performance_observer
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200801' AND
  feature = 'PerformanceObserverForWindow'
