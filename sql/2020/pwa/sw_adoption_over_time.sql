#standardSQL
# SW adoption over time - based on 2019/11_01b.sql
SELECT
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
