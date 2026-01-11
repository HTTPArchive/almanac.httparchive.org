#standardSQL
# Alt-Svc Protocol Analysis - Deep dive into Alternative Service headers
# Analyzes what protocols are advertised vs actually used

WITH alt_svc_analysis AS (
  SELECT
    client,
    page,
    url,
    is_main_document,
    
    -- CDN detection
    IFNULL(
      NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''),
      'ORIGIN'
    ) AS cdn,
    
    -- Current protocol used
    UPPER(IFNULL(
      JSON_EXTRACT_SCALAR(payload, '$._protocol'),
      IFNULL(
        NULLIF(JSON_EXTRACT_SCALAR(payload, '$._tls_next_proto'), 'unknown'),
        NULLIF(CONCAT('HTTP/', JSON_EXTRACT_SCALAR(payload, '$.response.httpVersion')), 'HTTP/')
      )
    )) AS current_protocol,
    
    -- Extract Alt-Svc header value
    (
      SELECT h.value
      FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'alt-svc'
      LIMIT 1
    ) AS alt_svc_header,
    
    -- Check if Alt-Svc exists
    EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'alt-svc'
    ) AS has_alt_svc
    
  FROM `httparchive.crawl.requests`
  WHERE date = '2025-07-01'
    AND EXISTS(
      SELECT 1
      FROM UNNEST(response_headers) AS h
      WHERE LOWER(h.name) = 'alt-svc'
    )
),

protocol_extraction AS (
  SELECT
    *,
    -- Extract HTTP/3 variants from Alt-Svc
    REGEXP_CONTAINS(LOWER(alt_svc_header), r'h3[^=]*=') AS advertises_h3,
    REGEXP_CONTAINS(LOWER(alt_svc_header), r'h3-\d+[^=]*=') AS advertises_h3_draft,
    REGEXP_CONTAINS(LOWER(alt_svc_header), r'h2[^=]*=') AS advertises_h2,
    REGEXP_CONTAINS(LOWER(alt_svc_header), r'http/1\.1[^=]*=') AS advertises_h1,
    
    -- Extract max-age values
    SAFE_CAST(REGEXP_EXTRACT(alt_svc_header, r'ma=(\d+)') AS INT64) AS max_age_seconds,
    
    -- Check for clear directive
    REGEXP_CONTAINS(LOWER(alt_svc_header), r'clear') AS has_clear_directive
    
  FROM alt_svc_analysis
)

SELECT
  client,
  cdn,
  is_main_document,
  current_protocol,
  COUNT(*) AS total_requests,
  
  -- Protocol advertising analysis
  COUNTIF(advertises_h3) AS advertises_h3_count,
  ROUND(SAFE_DIVIDE(COUNTIF(advertises_h3), COUNT(*)) * 100, 2) AS advertises_h3_pct,
  
  COUNTIF(advertises_h3_draft) AS advertises_h3_draft_count,
  ROUND(SAFE_DIVIDE(COUNTIF(advertises_h3_draft), COUNT(*)) * 100, 2) AS advertises_h3_draft_pct,
  
  COUNTIF(advertises_h2) AS advertises_h2_count,
  ROUND(SAFE_DIVIDE(COUNTIF(advertises_h2), COUNT(*)) * 100, 2) AS advertises_h2_pct,
  
  COUNTIF(advertises_h1) AS advertises_h1_count,
  ROUND(SAFE_DIVIDE(COUNTIF(advertises_h1), COUNT(*)) * 100, 2) AS advertises_h1_pct,
  
  -- Protocol mismatch analysis
  COUNTIF(advertises_h3 AND current_protocol NOT LIKE '%H3%' AND current_protocol != 'HTTP/3') AS h3_advertised_not_used,
  COUNTIF(current_protocol LIKE '%H3%' OR current_protocol = 'HTTP/3') AS currently_using_h3,
  
  -- Max-age statistics
  APPROX_QUANTILES(max_age_seconds, 100)[OFFSET(50)] AS median_max_age_seconds,
  APPROX_QUANTILES(max_age_seconds, 100)[OFFSET(90)] AS p90_max_age_seconds,
  
  -- Clear directive usage
  COUNTIF(has_clear_directive) AS clear_directive_count,
  ROUND(SAFE_DIVIDE(COUNTIF(has_clear_directive), COUNT(*)) * 100, 2) AS clear_directive_pct,
  
  -- Sample Alt-Svc headers for analysis
  ARRAY_AGG(alt_svc_header IGNORE NULLS LIMIT 5) AS sample_alt_svc_headers
  
FROM protocol_extraction
GROUP BY 
  client,
  cdn,
  is_main_document,
  current_protocol
HAVING 
  total_requests >= 100
ORDER BY 
  client DESC,
  total_requests DESC,
  advertises_h3_pct DESC
