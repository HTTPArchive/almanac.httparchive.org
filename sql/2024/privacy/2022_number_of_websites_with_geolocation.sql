#standardSQL
# Pages that use geolocation features

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature LIKE '%Geolocation%'
ORDER BY
  feature,
  client
