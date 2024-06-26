#standardSQL
# PWA features tracked in blink_features.usage
SELECT
  client,
  feature,
  num_urls,
  total_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200801' AND (
    feature LIKE '%ServiceWorker%' OR
    feature LIKE '%BackgroundSync%' OR
    feature LIKE '%GetInstalledRelatedApps%'
  )
ORDER BY
  client,
  num_urls,
  feature
