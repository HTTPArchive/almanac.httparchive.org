#standardSQL
# PWA features tracked in blink_features.usage
SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  num_urls / total_urls AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  (
    feature LIKE '%ServiceWorker%' OR
    feature LIKE '%BackgroundSync%' OR
    feature LIKE '%GetInstalledRelatedApps%'
  )
ORDER BY
  num_urls DESC,
  client,
  feature
