#standardSQL
# Number of pages that contain a <dialog> element

SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'DialogElement'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
