#standardSQL
# 08_08 Modern cipher suites 
#             | TLS_AES_128_GCM_SHA256       | {0x13,0x01} |
#             | TLS_AES_256_GCM_SHA384       | {0x13,0x02} |
#             | TLS_CHACHA20_POLY1305_SHA256 | {0x13,0x03} |
#             | TLS_AES_128_CCM_SHA256       | {0x13,0x04} |
#             | TLS_AES_128_CCM_8_SHA256     | {0x13,0x05} |
SELECT 
  COUNT(0) tls_request_count,
  COUNTIF(FORMAT("%'x", CAST(JSON_EXTRACT(payload, '$._tls_cipher_suite') AS int64)) IN ("1301", "1302", "1303", "1304", "1305")) AS modern_cipher_count
FROM 
   `httparchive.requests.2019_07_01_*`
WHERE
  JSON_EXTRACT(payload, '$._securityDetails') IS NOT NULL
