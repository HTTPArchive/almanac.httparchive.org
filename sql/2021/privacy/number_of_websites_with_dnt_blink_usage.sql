#standardSQL
# Pages that request DNT status (based on Blink features)

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
  feature = 'NavigatorDoNotTrack'
ORDER BY
  feature,
  client

# relevant Blink features:

# DNT: NavigatorDoNotTrack
