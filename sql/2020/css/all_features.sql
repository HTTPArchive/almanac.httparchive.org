SELECT
  client,
  feature,
  num_urls AS freq,
  total_urls AS total,
  pct_urls AS pct_pages
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20200801'
ORDER BY
  pct_pages DESC
