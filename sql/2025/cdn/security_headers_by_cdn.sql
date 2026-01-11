#standardSQL
# Security headers adoption by CDN vs Origin
# Analyzes adoption of key security headers across CDN providers

WITH security_headers AS (
  SELECT
    client,
    url,
    is_main_document,
    
    -- CDN detection
    IFNULL(
      NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''),
      'ORIGIN'
    ) AS cdn,
    
    -- Extract specific security headers
    -- Note: response_headers is an array, so we need to check each element
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'strict-transport-security'
    ) AS has_hsts,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'content-security-policy'
    ) AS has_csp,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'x-frame-options'
    ) AS has_xfo,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'x-content-type-options'
    ) AS has_xcto,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'x-xss-protection'
    ) AS has_xxp,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'referrer-policy'
    ) AS has_referrer_policy,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'permissions-policy'
    ) AS has_permissions_policy,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'feature-policy'
    ) AS has_feature_policy,
    
    -- Cache-Control directives
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'cache-control' 
      AND LOWER(h.value) LIKE '%no-store%'
    ) AS has_cache_no_store,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'cache-control' 
      AND LOWER(h.value) LIKE '%immutable%'
    ) AS has_cache_immutable,
    
    -- CORS headers
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'access-control-allow-origin'
    ) AS has_cors_origin,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'access-control-allow-methods'
    ) AS has_cors_methods,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'access-control-allow-headers'
    ) AS has_cors_headers,
    
    EXISTS(
      SELECT 1
FROM UNNEST(response_headers) AS h
WHERE LOWER(h.name) = 'access-control-allow-credentials'
    ) AS has_cors_credentials,
    
    -- Extract CORS origin values for analysis
    (
      SELECT h.value
      FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'access-control-allow-origin'
      LIMIT 1
    ) AS cors_origin_value
FROM `httparchive.crawl.requests`
WHERE date = '2025-07-01'
)

SELECT
  client,
  cdn,
  is_main_document,
  COUNT(0) AS total_requests,
  
  -- Security headers adoption
  COUNTIF(has_hsts) AS hsts_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_hsts), COUNT(0)) * 100, 2) AS hsts_pct,
  
  COUNTIF(has_csp) AS csp_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_csp), COUNT(0)) * 100, 2) AS csp_pct,
  
  COUNTIF(has_xfo) AS xfo_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_xfo), COUNT(0)) * 100, 2) AS xfo_pct,
  
  COUNTIF(has_xcto) AS xcto_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_xcto), COUNT(0)) * 100, 2) AS xcto_pct,
  
  COUNTIF(has_xxp) AS xxp_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_xxp), COUNT(0)) * 100, 2) AS xxp_pct,
  
  COUNTIF(has_referrer_policy) AS referrer_policy_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_referrer_policy), COUNT(0)) * 100, 2) AS referrer_policy_pct,
  
  COUNTIF(has_permissions_policy OR has_feature_policy) AS permissions_policy_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_permissions_policy OR has_feature_policy), COUNT(0)) * 100, 2) AS permissions_policy_pct,
  
  -- Cache control adoption
  COUNTIF(has_cache_no_store) AS cache_no_store_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cache_no_store), COUNT(0)) * 100, 2) AS cache_no_store_pct,
  
  COUNTIF(has_cache_immutable) AS cache_immutable_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cache_immutable), COUNT(0)) * 100, 2) AS cache_immutable_pct,
  
  -- CORS headers adoption
  COUNTIF(has_cors_origin) AS cors_origin_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cors_origin), COUNT(0)) * 100, 2) AS cors_origin_pct,
  
  COUNTIF(has_cors_methods) AS cors_methods_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cors_methods), COUNT(0)) * 100, 2) AS cors_methods_pct,
  
  COUNTIF(has_cors_headers) AS cors_headers_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cors_headers), COUNT(0)) * 100, 2) AS cors_headers_pct,
  
  COUNTIF(has_cors_credentials) AS cors_credentials_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_cors_credentials), COUNT(0)) * 100, 2) AS cors_credentials_pct,
  
  -- CORS origin patterns (sample values)
  ARRAY_AGG(cors_origin_value IGNORE NULLS LIMIT 5) AS sample_cors_origins,
  
  -- Wildcard CORS usage
  COUNTIF(cors_origin_value = '*') AS cors_wildcard_count,
  ROUND(SAFE_DIVIDE(COUNTIF(cors_origin_value = '*'), COUNTIF(has_cors_origin)) * 100, 2) AS cors_wildcard_pct,
  
  -- Security score (how many headers out of 7 main ones)
  ROUND(AVG(
    CAST(has_hsts AS INT64) + 
    CAST(has_csp AS INT64) + 
    CAST(has_xfo AS INT64) + 
    CAST(has_xcto AS INT64) + 
    CAST(has_xxp AS INT64) + 
    CAST(has_referrer_policy AS INT64) + 
    CAST(has_permissions_policy OR has_feature_policy AS INT64)
  ), 2) AS avg_security_headers
FROM security_headers
GROUP BY client,
  cdn,
  is_main_document
HAVING
  total_requests >= 1000
ORDER BY client DESC,
  avg_security_headers DESC,
  total_requests DESC
