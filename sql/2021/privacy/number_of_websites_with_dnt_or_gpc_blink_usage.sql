#standardSQL
# Pages that request DNT status (based on Blink features)

SELECT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'NavigatorDoNotTrack'
ORDER BY
  2 ASC, 1 ASC

# relevant Blink features:

# DNT: NavigatorDoNotTrack
# GPC: none
