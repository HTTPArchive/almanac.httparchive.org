#standardSQL
# 17_19: Percentage of HTTPS responses by protocol
SELECT
  client, cdn, firstHtml,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.0') AS tls10,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.1') AS tls11,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.2') AS tls12,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.3') AS tls13,
  ROUND(100 * COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.0') / COUNT(0), 2) AS tls10_pct,
  ROUND(100 * COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.1') / COUNT(0), 2) AS tls11_pct,
  ROUND(100 * COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.2') / COUNT(0), 2) AS tls12_pct,
  ROUND(100 * COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.3') / COUNT(0), 2) AS tls13_pct,
  COUNT(0) AS total
FROM (
  SELECT
    client, page, url, firstHtml,
    # WPT is inconsistent with protocol population.
    upper(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS ')))) AS protocol,
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tlsVersion,

    # WPT joins CDN detection but we bias to the DNS detection which is the first entry
    IFNULL(NULLIF(REGEXP_EXTRACT(_cdn_provider, r'^([^,]*).*'), ''), 'ORIGIN') AS cdn,
    CAST(JSON_EXTRACT(payload, '$.timings.ssl') AS INT64) AS tlstime,

    # isSecure reports what the browser thought it was going to use, but it can get upgraded with STS OR UpgradeInsecure: 1
    IF(STARTS_WITH(url, 'https') OR JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL OR CAST(JSON_EXTRACT(payload, '$._is_secure') AS INT64) = 1, TRUE, FALSE) AS isSecure,
    CAST(jSON_EXTRACT(payload, '$._socket') AS INT64) AS socket
  FROM
    `httparchive.almanac.requests3`
  WHERE
    # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
    resp_location = '' OR resp_location IS NULL
) a
LEFT JOIN (
  SELECT
    client, page,
    CAST(jSON_EXTRACT(payload, '$._socket') AS INT64) AS socket,
    ANY_VALUE(upper(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))))) AS protocol,
    ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._tls_version')) AS tlsVersion
  FROM `httparchive.almanac.requests3`
  WHERE
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL AND
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))) IS NOT NULL AND
    jSON_EXTRACT(payload, '$._socket') IS NOT NULL
  GROUP BY client, page, socket
) b ON (a.client = b.client AND a.page = b.page AND a.socket = b.socket)

GROUP BY
  client,
  cdn,
  firstHtml
ORDER BY
  client DESC,
  total DESC
