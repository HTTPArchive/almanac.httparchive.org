#standardSQL
# Cache-Control and CDN caching behavior analysis
# Analyzes cache directives and actual caching behavior

WITH cache_analysis AS (
  SELECT
    client,
    is_main_document,
    
    -- CDN detection
    IFNULL(
      NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''),
      'ORIGIN'
    ) AS cdn,
    
    -- Content type
    JSON_EXTRACT_SCALAR(summary, '$._contentType') AS content_type,
    
    -- Response status
    SAFE_CAST(JSON_EXTRACT_SCALAR(payload, '$.response.status') AS INT64) AS status_code,
    
    -- Extract cache-control header value
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'cache-control'
LIMIT 1) AS cache_control,
    
    -- Extract other cache-related headers
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'expires'
LIMIT 1) AS expires_header,
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'etag'
LIMIT 1) AS etag,
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'last-modified'
LIMIT 1) AS last_modified,
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'vary'
LIMIT 1) AS vary_header,
    
    -- CDN-specific headers
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'x-cache'
LIMIT 1) AS x_cache,
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'cf-cache-status'
LIMIT 1) AS cf_cache_status,
    (SELECT value
FROM UNNEST(response_headers)
WHERE LOWER(name) = 'x-served-by'
LIMIT 1) AS x_served_by
FROM `httparchive.crawl.requests`
WHERE date = '2025-07-01'
)

SELECT
  client,
  cdn,
  is_main_document,
  COUNT(0) AS total_requests,
  
  -- Cache-Control directives analysis
  COUNTIF(cache_control IS NOT NULL) AS has_cache_control,
  ROUND(SAFE_DIVIDE(COUNTIF(cache_control IS NOT NULL), COUNT(0)) * 100, 2) AS cache_control_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'public')) AS is_public,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'public')), COUNT(0)) * 100, 2) AS public_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'private')) AS is_private,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'private')), COUNT(0)) * 100, 2) AS private_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'no-cache')) AS is_no_cache,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'no-cache')), COUNT(0)) * 100, 2) AS no_cache_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'no-store')) AS is_no_store,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'no-store')), COUNT(0)) * 100, 2) AS no_store_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'max-age=0')) AS is_max_age_zero,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'max-age=0')), COUNT(0)) * 100, 2) AS max_age_zero_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'immutable')) AS is_immutable,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'immutable')), COUNT(0)) * 100, 2) AS immutable_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r's-maxage')) AS has_s_maxage,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r's-maxage')), COUNT(0)) * 100, 2) AS s_maxage_pct,
  
  -- Modern cache directives
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'stale-while-revalidate')) AS has_stale_while_revalidate,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'stale-while-revalidate')), COUNT(0)) * 100, 2) AS stale_while_revalidate_pct,
  
  COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'stale-if-error')) AS has_stale_if_error,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(cache_control), r'stale-if-error')), COUNT(0)) * 100, 2) AS stale_if_error_pct,
  
  -- Max-age value analysis
  APPROX_QUANTILES(
    SAFE_CAST(REGEXP_EXTRACT(cache_control, r'max-age=(\d+)') AS INT64), 100
  )[OFFSET(50)] AS median_max_age_seconds,
  
  APPROX_QUANTILES(
    SAFE_CAST(REGEXP_EXTRACT(cache_control, r's-maxage=(\d+)') AS INT64), 100
  )[OFFSET(50)] AS median_s_maxage_seconds,
  
  -- Cache hit/miss analysis from CDN headers
  COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'hit')) AS cache_hits,
  COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'miss')) AS cache_misses,
  ROUND(SAFE_DIVIDE(
    COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'hit')),
    COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'hit|miss'))
  ) * 100, 2) AS cache_hit_rate_pct,
  
  -- Cloudflare-specific cache status
  COUNTIF(REGEXP_CONTAINS(LOWER(cf_cache_status), r'hit')) AS cf_cache_hits,
  COUNTIF(REGEXP_CONTAINS(LOWER(cf_cache_status), r'miss')) AS cf_cache_misses,
  COUNTIF(REGEXP_CONTAINS(LOWER(cf_cache_status), r'dynamic')) AS cf_cache_dynamic,
  
  -- Validation headers
  COUNTIF(etag IS NOT NULL) AS has_etag,
  ROUND(SAFE_DIVIDE(COUNTIF(etag IS NOT NULL), COUNT(0)) * 100, 2) AS etag_pct,
  
  COUNTIF(last_modified IS NOT NULL) AS has_last_modified,
  ROUND(SAFE_DIVIDE(COUNTIF(last_modified IS NOT NULL), COUNT(0)) * 100, 2) AS last_modified_pct,
  
  -- CDN cache hit indicators
  COUNTIF(x_cache IS NOT NULL) AS has_x_cache,
  COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'hit')) AS cache_hit_count,
  ROUND(SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(LOWER(x_cache), r'hit')), COUNTIF(x_cache IS NOT NULL)) * 100, 2) AS cache_hit_rate,
  
  -- Cloudflare specific
  COUNTIF(cf_cache_status = 'HIT') AS cf_hits,
  COUNTIF(cf_cache_status = 'MISS') AS cf_misses,
  ROUND(SAFE_DIVIDE(COUNTIF(cf_cache_status = 'HIT'), COUNTIF(cf_cache_status IS NOT NULL)) * 100, 2) AS cf_hit_rate
FROM cache_analysis
WHERE status_code = 200  -- Focus on successful responses
GROUP BY client,
  cdn,
  is_main_document
HAVING
  total_requests >= 1000
ORDER BY client DESC,
  total_requests DESC
