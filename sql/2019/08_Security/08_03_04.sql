#standardSQL
# 08_03: and 08_04: - RSA and ECDSA certificates
SELECT 
  count(0) total,
  countif(IF (tls13, TO_HEX(FROM_BASE64(REPLACE(REGEXP_REPLACE(JSON_EXTRACT_SCALAR(payload, '$._certificates[0]'), "-----(BEGIN|END) CERTIFICATE-----", ""), "\n", ""))) LIKE "%2a8648ce3d0201%", REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._securityDetails.keyExchange'), r'ECDSA'))) is_ecdsa,
  countif(IF (tls13, TO_HEX(FROM_BASE64(REPLACE(REGEXP_REPLACE(JSON_EXTRACT_SCALAR(payload, '$._certificates[0]'), "-----(BEGIN|END) CERTIFICATE-----", ""), "\n", ""))) LIKE "%2a864886f70d010101%", REGEXP_CONTAINS(JSON_EXTRACT(payload, '$._securityDetails.keyExchange'), r'RSA'))) is_rsa
FROM 
(
  SELECT 
    JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') = 'TLS 1.3' tls13,
    payload
  FROM 
   `httparchive.requests.2019_07_01_*`
  WHERE 
    JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL AND
    JSON_EXTRACT_SCALAR(payload, '$._certificates[0]') IS NOT NULL
)
