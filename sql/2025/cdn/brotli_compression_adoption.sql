#standardSQL
# 20_brotli_compression_adoption.sql: Brotli and modern compression adoption by CDN
# Analyzes compression algorithm usage patterns and efficiency across CDN providers
#
# Rationale: Brotli compression offers 20-30% better compression than gzip for text resources.
# As it becomes more widely supported, we want to track which CDNs are leading adoption
# and how much bandwidth savings are being achieved. This is critical for performance
# and sustainability metrics.

WITH compression_analysis AS (
  SELECT
    client,

    -- CDN detection
    IFNULL(
      NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''),
      'ORIGIN'
    ) AS cdn,

    -- Page and resource info
    page,
    url,
    is_main_document,

    -- Content type classification
    CASE
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(js|mjs)($|\?)') THEN 'JavaScript'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.css($|\?)') THEN 'CSS'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(html|htm)($|\?)') OR is_main_document THEN 'HTML'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(json)($|\?)') THEN 'JSON'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(svg)($|\?)') THEN 'SVG'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(woff2?|ttf|otf|eot)($|\?)') THEN 'Fonts'
      WHEN REGEXP_CONTAINS(LOWER(url), r'\.(jpg|jpeg|png|gif|webp|avif)($|\?)') THEN 'Images'
      ELSE 'Other'
    END AS content_type,

    -- Compression detection from Content-Encoding header
    (
      SELECT LOWER(h.value)
      FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'content-encoding'
      LIMIT 1
    ) AS content_encoding,

    -- Vary header check (indicates dynamic compression support)
    EXISTS(
      SELECT 1 FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'vary' AND LOWER(h.value) LIKE '%accept-encoding%'
    ) AS supports_dynamic_compression,

    -- Response size metrics
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.response.bodySize') AS INT64) AS response_body_size,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.response.bodySize') AS INT64) AS uncompressed_size,

    -- Transfer size (actual bytes transferred)
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.response._transferSize') AS INT64) AS transfer_size
  FROM `httparchive.crawl.requests`
  WHERE date = '2025-07-01' AND
    -- Focus on compressible content types
    REGEXP_CONTAINS(LOWER(url), r'\.(js|mjs|css|html|htm|json|svg|xml|txt)($|\?)')
)

SELECT
  client,
  cdn,
  content_type,

  -- Volume metrics
  COUNT(DISTINCT page) AS total_pages,
  COUNT(0) AS total_requests,

  -- Compression type distribution
  COUNTIF(content_encoding = 'br') AS brotli_requests,
  COUNTIF(content_encoding = 'gzip') AS gzip_requests,
  COUNTIF(content_encoding = 'deflate') AS deflate_requests,
  COUNTIF(content_encoding IS NULL OR content_encoding = '') AS uncompressed_requests,
  COUNTIF(content_encoding NOT IN ('br', 'gzip', 'deflate', '') AND content_encoding IS NOT NULL) AS other_compression,

  -- Compression percentages
  ROUND(SAFE_DIVIDE(COUNTIF(content_encoding = 'br'), COUNT(0)) * 100, 2) AS brotli_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(content_encoding = 'gzip'), COUNT(0)) * 100, 2) AS gzip_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(content_encoding = 'deflate'), COUNT(0)) * 100, 2) AS deflate_pct,
  ROUND(SAFE_DIVIDE(COUNTIF(content_encoding IS NULL OR content_encoding = ''), COUNT(0)) * 100, 2) AS uncompressed_pct,

  -- Dynamic compression support
  COUNTIF(supports_dynamic_compression) AS dynamic_compression_count,
  ROUND(SAFE_DIVIDE(COUNTIF(supports_dynamic_compression), COUNT(0)) * 100, 2) AS dynamic_compression_pct,

  -- Size metrics (in KB)
  ROUND(AVG(response_body_size) / 1024, 2) AS avg_response_size_kb,
  ROUND(AVG(CASE WHEN content_encoding = 'br' THEN response_body_size END) / 1024, 2) AS avg_brotli_size_kb,
  ROUND(AVG(CASE WHEN content_encoding = 'gzip' THEN response_body_size END) / 1024, 2) AS avg_gzip_size_kb,
  ROUND(AVG(CASE WHEN content_encoding IS NULL OR content_encoding = '' THEN response_body_size END) / 1024, 2) AS avg_uncompressed_size_kb,

  -- Compression efficiency comparison
  ROUND(
    SAFE_DIVIDE(
      AVG(CASE WHEN content_encoding = 'gzip' THEN response_body_size END) -
      AVG(CASE WHEN content_encoding = 'br' THEN response_body_size END),
      AVG(CASE WHEN content_encoding = 'gzip' THEN response_body_size END)
    ) * 100, 2
  ) AS brotli_vs_gzip_savings_pct,

  -- Total data transfer metrics
  ROUND(SUM(response_body_size) / (1024 * 1024 * 1024), 2) AS total_gb_transferred,
  ROUND(SUM(CASE WHEN content_encoding = 'br' THEN response_body_size END) / (1024 * 1024 * 1024), 2) AS total_gb_brotli,
  ROUND(SUM(CASE WHEN content_encoding = 'gzip' THEN response_body_size END) / (1024 * 1024 * 1024), 2) AS total_gb_gzip
FROM compression_analysis
GROUP BY
  client,
  cdn,
  content_type
HAVING
  total_requests >= 100  -- Minimum threshold for statistical relevance
ORDER BY
  client DESC,
  brotli_pct DESC,
  total_requests DESC
