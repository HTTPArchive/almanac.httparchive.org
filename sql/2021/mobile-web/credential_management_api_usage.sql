#standardSQL
# Usage of Credential Manager
SELECT DISTINCT
  client,
  feature,
  num_urls AS freq,
  total_urls AS total,
  pct_urls AS pct
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20210701' AND
  feature = 'CredentialManagerGet'
