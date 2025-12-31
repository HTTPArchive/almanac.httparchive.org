#standardSQL
# distribution_of_http_versions: Percentage of HTTPS responses by protocol
SELECT
  a.client,
  cdn,
  is_main_document,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/0.9') AS http09,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.0') AS http10,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.1') AS http11,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/2') AS http2,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'H3-29' OR IFNULL(a.protocol, b.protocol) = 'H3-Q050') AS http3,
  COUNTIF(IFNULL(a.protocol, b.protocol) NOT IN ('HTTP/0.9', 'HTTP/1.0', 'HTTP/1.1', 'HTTP/2', 'H3-29', 'H3-Q050')) AS http_other,
  COUNTIF(isSecure OR IFNULL(a.protocol, b.protocol) = 'HTTP/2') AS tls_total,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/0.9') / COUNT(0) AS http09_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.0') / COUNT(0) AS http10_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/1.1') / COUNT(0) AS http11_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'HTTP/2') / COUNT(0) AS http2_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) = 'H3-29' OR IFNULL(a.protocol, b.protocol) = 'H3-Q050') / COUNT(0) AS http3_pct,
  COUNTIF(IFNULL(a.protocol, b.protocol) NOT IN ('HTTP/0.9', 'HTTP/1.0', 'HTTP/1.1', 'HTTP/2', 'H3-29', 'H3-Q050')) / COUNT(0) AS http_other_pct,
  COUNTIF(isSecure OR IFNULL(a.protocol, b.protocol) = 'HTTP/2') / COUNT(0) AS tls_pct,
  COUNT(0) AS total
FROM
  (
    SELECT
      client,
      page,
      url,
      is_main_document,
      # WPT is inconsistent with protocol population.
      UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(CONCAT('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/')))) AS protocol,
      JSON_EXTRACT_SCALAR(payload, '$._tls_version') AS tlsVersion,

      # WPT joins CDN detection but we bias to the DNS detection which is the first entry
      IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn,
      SAFE_CAST(JSON_VALUE(payload, '$.timings.ssl') AS INT64) AS tlstime,

      # isSecure reports what the browser thought it was going to use, but it can get upgraded with STS OR UpgradeInsecure: 1
      IF(STARTS_WITH(url, 'https') OR JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL OR SAFE_CAST(JSON_VALUE(payload, '$._is_secure') AS INT64) = 1, TRUE, FALSE) AS isSecure,
      SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket
    FROM
      `httparchive.crawl.requests`
    CROSS JOIN UNNEST(response_headers) AS r
    WHERE
      # WPT changes the response fields based on a redirect (url becomes the Location path instead of the original) causing insonsistencies in the counts, so we ignore them
      date = '2025-07-01' AND
      r.name = 'location' AND
      (r.value = '' OR r.value IS NULL)
  ) a
LEFT JOIN
  (
    SELECT
      client,
      page,
      SAFE_CAST(JSON_VALUE(payload, '$._socket') AS INT64) AS socket,
      ANY_VALUE(UPPER(IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/'))))) AS protocol,
      ANY_VALUE(JSON_EXTRACT_SCALAR(payload, '$._tls_version')) AS tlsVersion
    FROM
      `httparchive.crawl.requests`
    WHERE
      JSON_EXTRACT_SCALAR(payload, '$._tls_version') IS NOT NULL AND
      IFNULL(JSON_EXTRACT_SCALAR(payload, '$._protocol'), IFNULL(NULLIF(JSON_EXTRACT_SCALAR(
        payload, '$._tls_next_proto'), 'unknown'), NULLIF(concat(
        'HTTP/',
        JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')
      ), 'HTTP/'))) IS NOT NULL AND
      JSON_EXTRACT(payload, '$._socket') IS NOT NULL AND
      date = '2025-07-01'
    GROUP BY
      client,
      page,
      socket
  ) b
ON (a.client = b.client AND a.page = b.page AND a.socket = b.socket)

GROUP BY
  client,
  cdn,
  is_main_document
ORDER BY
  client DESC,
  total DESC
