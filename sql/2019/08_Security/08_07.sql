#standardSQL
# 08_07 Autheticated cipher suites
SELECT 
  COUNTIF(JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL) tls_request_count,
  COUNTIF(JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL AND REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._securityDetails.cipher'), r'GCM|CCM|POLY1305') authenticated_cipher_count
FROM 
   `httparchive.requests.2019_07_01_*`
