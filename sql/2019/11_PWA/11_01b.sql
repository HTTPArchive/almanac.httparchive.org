#standardSQL
#
# Moved to leverage smaller "blink_features" table
# 7.92 MB

SELECT
  yyyymmdd AS date,
  client,
  num_urls AS freq,
  total_urls AS total,
  ROUND(pct_urls * 100, 2) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  feature = 'ServiceWorkerControlledPage'
ORDER BY
  date DESC,
  client
