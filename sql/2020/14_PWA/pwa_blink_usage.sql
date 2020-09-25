#standardSQL
# PWA features tracked in blink usage
SELECT
  client,
  feature,
  total_urls,
  SUM(IF(id = "1025" OR feature = "BackgroundSyncRegister", num_urls, 0)) AS BackgroundSyncRegister,
  ROUND(SUM(IF(id = "1025" OR feature = "BackgroundSyncRegister", num_urls, 0)) / total_urls * 100, 5) AS BackgroundSyncRegister_pct,
  SUM(IF(id = "745" OR feature = "BackgroundSync", num_urls, 0)) AS BackgroundSync,
  ROUND(SUM(IF(id = "745" OR feature = "BackgroundSync", num_urls, 0)) / total_urls * 100, 5) AS BackgroundSync_pct,
  SUM(IF(id = "2931" OR feature = "PeriodicBackgroundSyncRegister", num_urls, 0)) AS PeriodicBackgroundSyncRegister,
  ROUND(SUM(IF(id = "2931" OR feature = "PeriodicBackgroundSyncRegister", num_urls, 0)) / total_urls * 100, 5) AS PeriodicBackgroundSyncRegister_pct,
  SUM(IF(id = "2930" OR feature = "PeriodicBackgroundSync", num_urls, 0)) AS PeriodicBackgroundSync,
  ROUND(SUM(IF(id = "2930" OR feature = "PeriodicBackgroundSync", num_urls, 0)) / total_urls * 100, 5) AS PeriodicBackgroundSync_pct,
  SUM(IF(id = "1870" OR feature = "GetInstalledRelatedApps", num_urls, 0)) AS GetInstalledRelatedApps,
  ROUND(SUM(IF(id = "1870" OR feature = "PeriodicBackgroundSync", num_urls, 0)) / total_urls * 100, 5) AS GetInstalledRelatedApps_pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200801' AND
  (
      feature like '%BackgroundSync%' OR
      feature = 'V8Navigator_GetInstalledRelatedApps_Method' OR
      id in ('745','1025','2930','2931','1870')
  )
GROUP BY
  client,
  feature,
  total_urls
ORDER BY
  client,
  feature,
  total_urls
