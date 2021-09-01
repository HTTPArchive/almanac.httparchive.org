#standardSQL
# SW adoption over time
SELECT DISTINCT
  REGEXP_REPLACE(yyyymmdd, r'(\d{4})(\d{2})(\d{2})', r'\1-\2\-3') AS date,
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
