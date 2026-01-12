#standardSQL
# Section: Transport Security - HTTP Strict Transport Security
# Question: How many websites use HSTS includeSubDomains and preload?
SELECT
  client,
  COUNT(0) AS total_requests_with_hsts_header,
  COUNTIF(hsts_header_val IS NOT NULL) AS total_non_null_hsts_headers,
  SAFE_DIVIDE(COUNTIF(hsts_header_val IS NOT NULL), COUNT(0)) AS pct_hsts_requests,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)max-age\s*=\s*\d+') AND NOT REGEXP_CONTAINS(CONCAT(hsts_header_val, ' '), r'(?i)max-age\s*=\s*0\W')), COUNTIF(hsts_header_val IS NOT NULL)) AS pct_valid_max_age,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(CONCAT(hsts_header_val, ' '), r'(?i)max-age\s*=\s*0\W')), COUNTIF(hsts_header_val IS NOT NULL)) AS pct_zero_max_age,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)includeSubDomains')), COUNTIF(hsts_header_val IS NOT NULL)) AS pct_include_subdomains,
  SAFE_DIVIDE(COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)preload')), COUNTIF(hsts_header_val IS NOT NULL)) AS pct_preload
FROM (
  SELECT
    client,
    response_headers.value AS hsts_header_val
  FROM
    `httparchive.crawl.requests`,
    UNNEST(response_headers) AS response_headers
  WHERE
    date = '2025-07-01' AND
    is_root_page AND
    is_main_document AND
    LOWER(response_headers.name) = 'strict-transport-security'
)
GROUP BY
  client
