#standardSQL
# Usage of Navigator.deviceMemory
SELECT
  client,
  feature,
  num_urls AS freq,
  total_urls AS total,
  pct_urls AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'NavigatorDeviceMemory'
