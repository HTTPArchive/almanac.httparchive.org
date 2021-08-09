#standardSQL
# 08_03: and 08_04: - RSA and ECDSA certificates
CREATE TEMPORARY FUNCTION getHexCert(cert STRING) RETURNS STRING AS (
  TO_HEX(FROM_BASE64(REPLACE(REGEXP_REPLACE(cert, "-----(BEGIN|END) CERTIFICATE-----", ""), "\n", "")))
);

SELECT
  client,
  is_ecdsa,
  is_rsa,
  total,
  ROUND(is_ecdsa * 100 / total, 2) AS pct_ecdsa,
  ROUND(is_rsa * 100 / total, 2) AS pct_rsa
FROM (
  SELECT
    client,
    COUNTIF(IF(tls13,
      getHexCert(cert) LIKE "%2a8648ce3d0201%",
      REGEXP_CONTAINS(key_exchange, r'ECDSA')
    )) AS is_ecdsa,
    COUNTIF(IF(tls13,
      getHexCert(cert) LIKE "%2a864886f70d010101%",
      REGEXP_CONTAINS(key_exchange, r'RSA')
    )) AS is_rsa,
    COUNT(0) AS total
  FROM (
    SELECT
      _TABLE_SUFFIX AS client,
      JSON_EXTRACT_SCALAR(payload, '$._certificates[0]') AS cert,
      JSON_EXTRACT(payload, '$._securityDetails.keyExchange') AS key_exchange,
      JSON_EXTRACT_SCALAR(payload, '$._securityDetails.protocol') = 'TLS 1.3' AS tls13
    FROM
     `httparchive.requests.2019_07_01_*`)
  WHERE
    cert IS NOT NULL
  GROUP BY
    client)
