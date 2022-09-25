#standardSQL
# Number of pages that contain a <dialog> element

SELECT
  client,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'DialogElement'
