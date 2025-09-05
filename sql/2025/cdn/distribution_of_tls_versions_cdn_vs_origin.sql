#standardSQL
# distribution_of_tls_versions_cdn_vs_origin: Percentage of HTTPS responses by TLS Version with and without CDN
SELECT
  a.client,
  IF(cdn = 'ORIGIN', 'ORIGIN', 'CDN') AS cdn, is_main_document,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.0') AS tls10,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.1') AS tls11,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.2') AS tls12,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.3') AS tls13,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.0') / COUNT(0) AS tls10_pct,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.1') / COUNT(0) AS tls11_pct,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.2') / COUNT(0) AS tls12_pct,
  COUNTIF(IFNULL(a.tlsVersion, b.tlsVersion) = 'TLS 1.3') / COUNT(0) AS tls13_pct,
  COUNT(0) AS total
FROM
  (
    SELECT
      client,
      page,
      url,
      is_main_document,
      # WPT is inconsistent with protocol population.
      UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS ')))) AS protocol,
      JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tlsVersion,

      # WPT joins CDN detection but we bias to the DNS detection which is the first entry
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn,
      SAFE_CAST(JSON_VALUE(payload, '$.timings.ssl') AS INT64) AS tlstime,

      # isSecure reports what the browser thought it was going to use, but it can get upgraded with STS OR UpgradeInsecure: 1
      IF(STARTS_WITH(url, 'https') OR JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL OR SAFE_CAST(JSON_VALUE(payload, '$._is_secure') AS INT64) = 1, TRUE, FALSE) AS isSecure,
      SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket
    FROM
      `httparchive.crawl.requests`
    WHERE
      # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
      date = '2025-07-01'
  ) a
LEFT JOIN (
  SELECT
    client,
    page,
    SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket,
    ANY_VALUE(UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))))) AS protocol,
    ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._tls_version')) AS tlsVersion
  FROM `httparchive.crawl.requests`
  WHERE
    JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL AND
    IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('TLS ', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'TLS '))) IS NOT NULL AND
    JSON_EXTRACT(payload, '$._socket') IS NOT NULL AND
    date = '2025-07-01'
  GROUP BY
    client,
    page,
    socket
) b ON (a.client = b.client AND a.page = b.page AND a.socket = b.socket)
WHERE
  a.tlsVersion IS NOT NULL OR
  b.tlsVersion IS NOT NULL
GROUP BY
  a.client,
  cdn,
  is_main_document
ORDER BY
  a.client DESC,
  total DESC
