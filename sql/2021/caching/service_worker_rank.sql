#standardSQL
# Adoption of SW by CrUX rank
SELECT
  client,
  rank_magnitude AS rank,
  COUNT(DISTINCT IF(feature = 'ServiceWorkerControlledPage', url, NULL)) AS sw_pages,
  COUNT(DISTINCT url) AS total,
  COUNT(DISTINCT IF(feature = 'ServiceWorkerControlledPage', url, NULL)) / COUNT(DISTINCT url) AS pct
FROM
  `httparchive.blink_features.features`,
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
WHERE
  yyyymmdd = '2021-07-01' AND
  rank <= rank_magnitude
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
