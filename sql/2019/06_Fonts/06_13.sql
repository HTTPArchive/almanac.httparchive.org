#standardSQL

-- counts the number of usage of FontFace API

SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  feature = 'FontFaceConstructor' AND
  yyyymmdd = '20190701'
