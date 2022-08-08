#standardSQL
# Number of pages that contain `position: sticky` CSS property

SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220601' AND
  feature = 'PositionSticky'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
