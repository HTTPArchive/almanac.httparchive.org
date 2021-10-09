#standardSQL
# Pages that use a device sensor (based on Blink features)

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  (
    feature LIKE '%DeviceMotion%' OR
    feature LIKE '%DeviceOrientation%' OR
    feature LIKE '%DeviceProximity%' OR
    feature LIKE '%DeviceLight%'
  )
ORDER BY
  feature,
  client
