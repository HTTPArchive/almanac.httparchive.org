# standardSQL
# usage of AudioWorklet.addModule and PaintWorklet using blink features from usage counters
SELECT
  feature,
  client,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20240601' AND
  (
    feature = 'PaintWorklet' OR
    feature = 'AudioWorkletAddModule'
  )
GROUP BY
  feature,
  client,
  pct_urls
ORDER BY
  feature,
  client,
  pct_urls
