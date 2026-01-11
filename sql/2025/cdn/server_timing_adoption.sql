#standardSQL
# 32_server_timing_adoption.sql
# Deep dive into Server-Timing header usage across CDNs
# Server-Timing provides transparency into server-side performance metrics

WITH server_timing_analysis AS (
  SELECT
    client,
    page,
    url,
    is_main_document,
    IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), 'ORIGIN') AS cdn_provider,
    JSON_EXTRACT_SCALAR(payload, '$._protocol') AS protocol,

    -- Check for Server-Timing header
    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'server-timing'
    ) AS has_server_timing,

    -- Extract Server-Timing value for analysis
    (
      SELECT header.value
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'server-timing'
      LIMIT 1
    ) AS server_timing_value,

    -- Other performance headers
    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'x-cache'
    ) AS has_x_cache,

    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'x-cdn'
    ) AS has_x_cdn,

    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'cf-ray'  -- Cloudflare specific
    ) AS has_cf_ray,

    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS header
      WHERE LOWER(header.name) = 'x-amz-cf-id'  -- CloudFront specific
    ) AS has_amz_cf_id,

    -- Performance metrics
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.wait') AS FLOAT64) AS ttfb,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.ssl') AS FLOAT64) AS ssl_time,
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.timings.connect') AS FLOAT64) AS connect_time,

    -- Resource info
    JSON_EXTRACT_SCALAR(summary, '$.type') AS resource_type,
    JSON_EXTRACT_SCALAR(summary, '$.respSize') AS response_size
  FROM `httparchive.crawl.requests`
  WHERE date = '2025-07-01' AND
    client = 'mobile'
)

SELECT
  cdn_provider,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(0) AS total_requests,

  -- Server-Timing adoption
  COUNTIF(has_server_timing) AS requests_with_server_timing,
  SAFE_DIVIDE(COUNTIF(has_server_timing) * 100.0, COUNT(0)) AS pct_server_timing,

  -- Other transparency headers
  COUNTIF(has_x_cache) AS requests_with_x_cache,
  COUNTIF(has_x_cdn) AS requests_with_x_cdn,
  SAFE_DIVIDE(COUNTIF(has_x_cache) * 100.0, COUNT(0)) AS pct_x_cache,

  -- CDN-specific headers
  COUNTIF(has_cf_ray) AS cloudflare_ray_headers,
  COUNTIF(has_amz_cf_id) AS cloudfront_id_headers,

  -- Performance correlation
  AVG(CASE WHEN has_server_timing THEN ttfb END) AS avg_ttfb_with_timing,
  AVG(CASE WHEN NOT has_server_timing THEN ttfb END) AS avg_ttfb_without_timing,

  APPROX_QUANTILES(CASE WHEN has_server_timing THEN ttfb END, 100)[OFFSET(50)] AS median_ttfb_with_timing,
  APPROX_QUANTILES(CASE WHEN NOT has_server_timing THEN ttfb END, 100)[OFFSET(50)] AS median_ttfb_without_timing,

  -- Sample Server-Timing values
  ARRAY_AGG(DISTINCT server_timing_value IGNORE NULLS LIMIT 5) AS sample_timing_values,

  -- By resource type
  COUNTIF(resource_type = 'Document' AND has_server_timing) AS documents_with_timing,
  COUNTIF(resource_type = 'Script' AND has_server_timing) AS scripts_with_timing,
  COUNTIF(resource_type = 'Stylesheet' AND has_server_timing) AS styles_with_timing
FROM server_timing_analysis
WHERE cdn_provider IS NOT NULL
GROUP BY cdn_provider
HAVING total_requests > 1000
ORDER BY pct_server_timing DESC
LIMIT 100
