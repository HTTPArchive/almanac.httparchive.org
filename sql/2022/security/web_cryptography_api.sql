#standardSQL
SELECT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE (
  feature LIKE 'Crypto%' OR
  feature LIKE 'Subtle%'
) AND
yyyymmdd = '20220601'
ORDER BY
  pct_urls DESC
