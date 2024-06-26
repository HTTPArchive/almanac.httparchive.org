#standardSQL
# Cookie attributes (HttpOnly, Secure, SameSite, __Secure- and __Host- prefixes) for cookies set on first-party and third-party requests
CREATE TEMPORARY FUNCTION getSetCookieHeaders(headers STRING)
RETURNS ARRAY<STRING>
DETERMINISTIC
LANGUAGE js AS '''
  const parsed_headers = JSON.parse(headers);
  const cookies = parsed_headers.filter(h => h.name.match(/set-cookie/i));
  const cookieValues = cookies.map(h => h.value);
  return cookieValues;
''';

SELECT
  client,
  party,
  COUNT(0) AS total_cookies,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*httponly')) AS count_httponly,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*httponly')) / COUNT(0) AS pct_httponly,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*secure')) AS count_secure,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*secure')) / COUNT(0) AS pct_secure,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=')) AS count_samesite,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=')) / COUNT(0) AS pct_samesite,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*lax')) AS count_samesite_lax,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*lax')) / COUNT(0) AS pct_samesite_lax,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*strict')) AS count_samesite_strict,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*strict')) / COUNT(0) AS pct_samesite_strict,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*none')) AS count_samesite_none,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i);.*samesite\s*=\s*none')) / COUNT(0) AS pct_samesite_none,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i)^\s*__Secure-')) AS count_secure_prefix,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i)^\s*__Secure-')) / COUNT(0) AS pct_secure_prefix,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i)^\s*__Host-')) AS count_host_prefix,
  COUNTIF(REGEXP_CONTAINS(cookie_value, r'(?i)^\s*__Host-')) / COUNT(0) AS pct_host_prefix
FROM (
  SELECT
    client,
    getSetCookieHeaders(JSON_EXTRACT(payload, '$.response.headers')) AS cookie_values,
    IF(NET.REG_DOMAIN(url) = NET.REG_DOMAIN(page), 1, 3) AS party
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01'
),
  UNNEST(cookie_values) AS cookie_value
GROUP BY
  client,
  party
ORDER BY
  client,
  party
