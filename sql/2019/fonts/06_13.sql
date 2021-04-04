#standardSQL
# 06_13: Font Loading API usage
SELECT
  client,
  num_urls AS freq,
  total_urls AS total,
  ROUND(pct_urls * 100, 2) AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  feature = 'FontFaceConstructor' AND
  yyyymmdd = '20190701'
