#standardSQL
# Number of pages that use CSS cascade layers

SELECT
  client,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'CSSCascadeLayers'
