#standardSQL
# Number of pages that use CSS cascade layers

SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'CSSCascadeLayers'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
