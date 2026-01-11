#standardSQL
# h3_adoption_by_cdn_provider_FINAL_v2.sql: HTTP/3 adoption rates by CDN provider
# Simplified version without unnecessary isSecure field to avoid casting issues

SELECT
  client,
  IF(cdn = 'ORIGIN', 'ORIGIN', 'CDN') AS cdn_type,
  is_main_document,
  COUNT(0) AS total,

  -- Protocol counts
  COUNTIF(protocol = 'HTTP/0.9') AS http09,
  COUNTIF(protocol = 'HTTP/1.0') AS http10,
  COUNTIF(protocol = 'HTTP/1.1') AS http11,
  COUNTIF(protocol = 'HTTP/2') AS http2,
  COUNTIF(protocol IN ('H3-29', 'H3-Q050', 'H3', 'HTTP/3')) AS http3,
  COUNTIF(protocol NOT IN ('HTTP/0.9', 'HTTP/1.0', 'HTTP/1.1', 'HTTP/2', 'H3-29', 'H3-Q050', 'H3', 'HTTP/3')) AS http_other,

  -- Protocol percentages
  ROUND(SAFE_DIVIDE(COUNTIF(protocol = 'HTTP/1.1'), COUNT(0)) * 100, 2) AS http11_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(protocol = 'HTTP/2'), COUNT(0)) * 100, 2) AS http2_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(protocol IN ('H3-29', 'H3-Q050', 'H3', 'HTTP/3')), COUNT(0)) * 100, 2) AS http3_pct,

  -- HTTP/2+ adoption (includes HTTP/3)
  COUNTIF(protocol IN ('HTTP/2', 'H3-29', 'H3-Q050', 'H3', 'HTTP/3')) AS http2plus,
  ROUND(SAFE_DIVIDE(COUNTIF(protocol IN ('HTTP/2', 'H3-29', 'H3-Q050', 'H3', 'HTTP/3')), COUNT(0)) * 100, 2) AS http2plus_pct
FROM (
  SELECT
    client,
    is_main_document,

    # Protocol detection - using the same logic as distribution_of_http_versions.sql
    UPPER(IFNULL(
      JSON_EXTRACT_SCALAR(payload, '$._protocol'),
      IFNULL(
        NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'),
        NULLIF(CONCAT('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/')
      )
    )) AS protocol,

    # CDN detection - extract first CDN provider if multiple are listed
    IFNULL(
      NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''),
      'ORIGIN'
    ) AS cdn
  FROM `httparchive.crawl.requests`
  WHERE date = '2025-07-01'
)
WHERE protocol IS NOT NULL  -- Must have a detected protocol
GROUP BY
  client,
  cdn_type,
  is_main_document
HAVING
  total >= 1000  -- Only include CDNs with meaningful traffic volume
ORDER BY
  client DESC,
  total DESC
