#standardSQL
# SW controlled pages over time (2025) — dataset same, direct from blink_features.usage

SELECT DISTINCT
  date,
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
  client;
