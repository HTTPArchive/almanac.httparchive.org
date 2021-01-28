#standardSQL
# 09_25 Sites that lock display orientation (using ScreenOrientation.lock)
SELECT
  num_urls AS freq,
  total_urls AS total,
  ROUND(pct_urls * 100, 2) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  client = 'mobile' AND
  yyyymmdd = '20190701' AND
  feature = 'ScreenOrientationLock'
