#standardSQL
# 08_06: Cipher suites supporting forward secrecy
SELECT 
  COUNTIF(JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL) tls_request_count,
  COUNTIF(JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL AND (REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._securityDetails.keyExchange'), r'DHE') OR JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') = 'TLS 1.3')) forward_secrecy_count
FROM
   `httparchive.requests.2019_07_01_*`
