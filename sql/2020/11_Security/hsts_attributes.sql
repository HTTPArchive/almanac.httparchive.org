#standardSQL
# HSTS includeSubDomains and preload usage
SELECT
  client,
  COUNT(0) AS freq,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'max-age\s*=\s*[^0]')) / COUNT(0) AS pct_valid_max_age,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'max-age\s*=\s*0')) / COUNT(0) AS pct_zero_max_age,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, 'includeSubDomains')) / COUNT(0) AS pct_include_subdomains,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, 'preload')) / COUNT(0) AS pct_preload
FROM (
  SELECT
    client,
    REGEXP_EXTRACT(respOtherHeaders, r'(?i)\W?strict-transport-security =([^,]+)') AS hsts_header_val
  FROM
    `httparchive.almanac.requests`
  WHERE 
    date = '2020-08-01' AND
    firstHtml
  )
GROUP BY
  client
