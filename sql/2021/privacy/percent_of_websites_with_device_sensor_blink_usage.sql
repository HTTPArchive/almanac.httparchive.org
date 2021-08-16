SELECT
  client,
  feature,
  num_urls,
  total_urls,
  ROUND(pct_urls * 100, 2) AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210801' AND
  (
    feature LIKE '%DeviceMotion%' OR
    feature LIKE '%DeviceOrientation%' OR
    feature LIKE '%DeviceProximity%' OR
    feature LIKE '%DeviceLight%'
  )
ORDER BY
  feature
