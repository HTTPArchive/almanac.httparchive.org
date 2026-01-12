#standardSQL
# PWA features tracked in blink_features.usage (2025)
# Only dataset/date update; logic identical to 2022

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  SAFE_DIVIDE(num_urls, total_urls) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  date = '2025-07-01' AND (
    feature LIKE '%ServiceWorker%' OR
    feature LIKE '%BackgroundSync%' OR
    feature LIKE '%GetInstalledRelatedApps%'
  )
ORDER BY
  num_urls DESC,
  client,
  feature;
