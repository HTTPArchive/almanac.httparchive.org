#standardSQL
  # Section: Attack preventions - Web Cryptography API
  # Question: Which Web Cryptography APIs are used the most?
  # Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
SELECT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  (feature LIKE 'Crypto%' OR
    feature LIKE 'Subtle%') AND
  yyyymmdd = '20240601'
ORDER BY
  pct_urls DESC
