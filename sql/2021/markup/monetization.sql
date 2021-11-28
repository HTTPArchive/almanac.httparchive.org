#standardSQL

# returns the value of the monetization meta node
SELECT
  yyyymmdd,
  client,
  COUNTIF(feature = 'HTMLMetaElementMonetization') AS meta,
  COUNTIF(feature = 'HTMLLinkElementMonetization') AS link,
  COUNTIF(feature IN ('HTMLMetaElementMonetization', 'HTMLLinkElementMonetization')) AS either,
  COUNT(DISTINCT url) AS total,
  COUNTIF(feature = 'HTMLMetaElementMonetization') / COUNT(DISTINCT url) AS meta_pct,
  COUNTIF(feature = 'HTMLLinkElementMonetization') / COUNT(DISTINCT url) AS link_pct,
  COUNTIF(feature IN ('HTMLMetaElementMonetization', 'HTMLLinkElementMonetization')) / COUNT(DISTINCT url) AS either_pct
FROM
  `httparchive.blink_features.features`
WHERE
  yyyymmdd = '2021-07-01'
GROUP BY
  yyyymmdd,
  client
ORDER BY
  client,
  either DESC
