#standardSQL
# Section: Cookies - Cookie Attributes
# Question: What is the prevalence of cookie attributes (HttpOnly, Secure, SameSite, __Secure-, __Host- prefixes, ...) for cookies set on first-party and third-party requests?
# Note: NET.REG_DOMAIN does not use the private section of publicsuffix.org (e.g., all *.github.io sites are counted as the same party)
SELECT
  client,
  IF(NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), 1, 3) AS party,
  COUNT(0) AS total_cookies,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*httponly')) AS count_httponly,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*httponly')) / COUNT(0) AS pct_httponly,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*secure')) AS count_secure,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*secure')) / COUNT(0) AS pct_secure,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*partitioned')) AS count_partitioned,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*partitioned')) / COUNT(0) AS pct_partitioned,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=')) AS count_samesite,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=')) / COUNT(0) AS pct_samesite,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*lax')) AS count_samesite_lax,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*lax')) / COUNT(0) AS pct_samesite_lax,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*strict')) AS count_samesite_strict,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*strict')) / COUNT(0) AS pct_samesite_strict,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*none')) AS count_samesite_none,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*samesite\s*=\s*none')) / COUNT(0) AS pct_samesite_none,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*sameparty')) AS count_sameparty,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*sameparty')) / COUNT(0) AS pct_sameparty,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*max-age\s*=\s*.+')) AS count_max_age,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*max-age\s*=\s*.+')) / COUNT(0) AS pct_max_age,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*expires\s*=\s*.+')) AS count_expires,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i);.*expires\s*=\s*.+')) / COUNT(0) AS pct_expires,
  COUNTIF(NOT (REGEXP_CONTAINS(response_headers.value, r'(?i);.*max-age\s*=\s*.+') OR REGEXP_CONTAINS(response_headers.value, r'(?i);.*expires\s*=\s*.+'))) AS count_session,
  COUNTIF(NOT (REGEXP_CONTAINS(response_headers.value, r'(?i);.*max-age\s*=\s*.+') OR REGEXP_CONTAINS(response_headers.value, r'(?i);.*expires\s*=\s*.+'))) / COUNT(0) AS pct_session,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i)^\s*__Secure-')) AS count_secure_prefix,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i)^\s*__Secure-')) / COUNT(0) AS pct_secure_prefix,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i)^\s*__Host-')) AS count_host_prefix,
  COUNTIF(REGEXP_CONTAINS(response_headers.value, r'(?i)^\s*__Host-')) / COUNT(0) AS pct_host_prefix
FROM
  `httparchive.all.requests`,
  UNNEST(response_headers) AS response_headers
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  LOWER(response_headers.name) = 'set-cookie'
GROUP BY
  client,
  party
ORDER BY
  client,
  party
