#standardSQL
# Pages that use media devices

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND (
    feature LIKE '%MediaDevices%' OR
    feature LIKE '%MediaSession%' OR
    feature LIKE '%GetUserMedia%' OR
    feature LIKE '%GetDisplayMedia%'
  )
ORDER BY
  feature,
  client
