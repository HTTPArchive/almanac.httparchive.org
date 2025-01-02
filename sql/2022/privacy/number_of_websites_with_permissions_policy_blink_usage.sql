#standardSQL
# Pages that use Permissions Policy (based on Blink features)

SELECT DISTINCT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND (feature LIKE '%FeaturePolicy%' OR feature LIKE '%PermissionsPolicy%')
ORDER BY
  feature,
  client
