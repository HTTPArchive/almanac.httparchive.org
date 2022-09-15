#standardSQL
# SW adoption over time
SELECT DISTINCT
  yyyymmdd AS date,
  client,
  num_urls AS freq,
  total_urls AS total,
  pct_urls AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  feature = 'ServiceWorkerControlledPage'
ORDER BY
  date DESC,
  client
