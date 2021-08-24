#standardSQL
# Pages that request DNT status (based on Blink features)

SELECT
  client,
  feature,
  num_urls,
  total_urls,
  ROUND(pct_urls, 2) AS pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'NavigatorDoNotTrack'
ORDER BY
  feature

# releveant Blink features:

# DNT: NavigatorDoNotTrack
# GPC: none
