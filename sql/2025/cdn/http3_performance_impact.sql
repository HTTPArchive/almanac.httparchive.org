#standardSQL
# 33_http3_performance_impact.sql
# Comprehensive analysis of HTTP/3 performance impact vs HTTP/2
# Measures real-world performance differences between protocols

WITH protocol_performance AS (
  SELECT
    client,
    page,
    url,
    is_main_document,
    IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn_provider,

    -- Protocol normalization
    CASE
      WHEN JSON_EXTRACT_SCALAR(payload, '$._protocol') IN ('h3', 'HTTP/3', 'QUIC') THEN 'H3'
      WHEN JSON_EXTRACT_SCALAR(payload, '$._protocol') = 'HTTP/2' THEN 'HTTP/2'
      WHEN JSON_EXTRACT_SCALAR(payload, '$._protocol') IN ('http/1.1', 'http/1.0') THEN 'HTTP/1.x'
      ELSE JSON_EXTRACT_SCALAR(payload, '$._protocol')
    END AS protocol,

    -- Performance metrics
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.wait') AS FLOAT64) AS ttfb,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.receive') AS FLOAT64) AS download_time,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.ssl') AS FLOAT64) AS ssl_time,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.connect') AS FLOAT64) AS connect_time,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.dns') AS FLOAT64) AS dns_time,

    -- Total request time
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.time') AS FLOAT64) AS total_time,

    -- Resource information
    SAFE_CAST(JSON_EXTRACT_SCALAR(summary, '$.respSize') AS INT64) AS response_size,
    JSON_EXTRACT_SCALAR(summary, '$.type') AS resource_type,
    JSON_EXTRACT_SCALAR(summary, '$.format') AS format,

    -- Connection reuse
    JSON_EXTRACT_SCALAR(payload, '$._socket') AS socket_id,

    -- Priority information
    JSON_EXTRACT_SCALAR(payload, '$._priority') AS priority
  FROM `httparchive.crawl.requests`
  WHERE date = '2025-07-01' AND
    client = 'mobile'
)

SELECT
  cdn_provider,
  protocol,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(0) AS total_requests,

  -- Performance metrics by protocol
  APPROX_QUANTILES(ttfb, 100)[OFFSET(25)] AS p25_ttfb,
  APPROX_QUANTILES(ttfb, 100)[OFFSET(50)] AS median_ttfb,
  APPROX_QUANTILES(ttfb, 100)[OFFSET(75)] AS p75_ttfb,
  APPROX_QUANTILES(ttfb, 100)[OFFSET(90)] AS p90_ttfb,

  AVG(ttfb) AS avg_ttfb,
  STDDEV(ttfb) AS stddev_ttfb,

  -- Download performance
  APPROX_QUANTILES(download_time, 100)[OFFSET(50)] AS median_download_time,
  AVG(download_time) AS avg_download_time,

  -- Connection establishment
  AVG(connect_time) AS avg_connect_time,
  AVG(ssl_time) AS avg_ssl_time,
  AVG(dns_time) AS avg_dns_time,

  -- Total time metrics
  APPROX_QUANTILES(total_time, 100)[OFFSET(50)] AS median_total_time,
  AVG(total_time) AS avg_total_time,

  -- Resource size analysis
  AVG(response_size) AS avg_response_size,
  SUM(response_size) AS total_bytes_transferred,

  -- Efficiency metrics (bytes per millisecond)
  SAFE_DIVIDE(AVG(response_size), AVG(total_time)) AS avg_throughput,

  -- Connection reuse (unique sockets vs requests)
  COUNT(DISTINCT socket_id) AS unique_connections,
  SAFE_DIVIDE(COUNT(0), COUNT(DISTINCT socket_id)) AS avg_requests_per_connection,

  -- Resource type breakdown
  COUNTIF(resource_type = 'Document') AS document_requests,
  COUNTIF(resource_type = 'Script') AS script_requests,
  COUNTIF(resource_type = 'Stylesheet') AS style_requests,
  COUNTIF(resource_type = 'Image') AS image_requests
FROM protocol_performance
WHERE protocol IN ('H3', 'HTTP/2', 'HTTP/1.x') AND
  ttfb IS NOT NULL AND
  ttfb > 0 AND
  ttfb < 10000  -- Filter outliers
GROUP BY cdn_provider, protocol
HAVING total_requests > 1000
ORDER BY cdn_provider, protocol
