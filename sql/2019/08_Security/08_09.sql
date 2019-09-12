#standardSQL
# 08_09 Legacy cipher suites
# Distribution of all ciphers
SELECT 
  _TABLE_SUFFIX AS client,
  JSON_EXTRACT(payload, '$._securityDetails.cipher') cipher,
  COUNT(*) cipher_count
FROM 
   `httparchive.requests.2019_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL
GROUP BY 
  client, cipher
ORDER BY 
  kount DESC
