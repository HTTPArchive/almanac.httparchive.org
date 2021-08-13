#standardSQL
# SW adoption over time
SELECT DISTINCT
  SUBSTRING(yyyymmdd, 0, 4) || '-' || SUBSTRING(yyyymmdd, 5, 2) || '-' || RIGHT(yyyymmdd, 2) AS date,
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
