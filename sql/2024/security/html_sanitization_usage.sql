#standardSQL
  # Section: Attack preventions - HTML Sanitization
  # Question: How often is setHTMLUnsafe and parseHTMLUnsafe used?
  # Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
  # Note: https://chromestatus.com/feature/6560361081995264
  # Note: very rare!
SELECT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20240601' AND
  feature IN UNNEST(['SetHTMLUnsafe', 'ParseHTMLUnsafe'])
ORDER BY
  pct_urls DESC
