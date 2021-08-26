#standardSQL
# HSTS includeSubDomains and preload usage
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(hsts_header_val IS NOT NULL) AS total_hsts_headers,
  COUNTIF(hsts_header_val IS NOT NULL) / COUNT(0) AS pct_hsts_requests,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)max-age\s*=\s*\d+') AND NOT REGEXP_CONTAINS(CONCAT(hsts_header_val, ' '), r'(?i)max-age\s*=\s*0\W')) / COUNTIF(hsts_header_val IS NOT NULL) AS pct_valid_max_age,
  COUNTIF(REGEXP_CONTAINS(CONCAT(hsts_header_val, ' '), r'(?i)max-age\s*=\s*0\W')) / COUNTIF(hsts_header_val IS NOT NULL) AS pct_zero_max_age,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)includeSubDomains')) / COUNTIF(hsts_header_val IS NOT NULL) AS pct_include_subdomains,
  COUNTIF(REGEXP_CONTAINS(hsts_header_val, r'(?i)preload')) / COUNTIF(hsts_header_val IS NOT NULL) AS pct_preload
FROM (
  SELECT
    client,
    REGEXP_EXTRACT(respOtherHeaders, r'(?i)strict-transport-security =([^,]+)') AS hsts_header_val
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml
)
GROUP BY
  client
