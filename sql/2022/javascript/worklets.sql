# standardSQL
# usage of PaintWorklet using blink features from usage counters
SELECT
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20220401' AND
  feature = 'PaintWorklet'
GROUP BY
  pct_urls,
  client
ORDER BY
  pct_urls,
  client
