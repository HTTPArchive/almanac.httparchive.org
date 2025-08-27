#standardSQL
# Percent of third-party requests with security headers

WITH requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    pageid AS page,
    url,
    RTRIM(urlShort, '/') AS origin,
    respOtherHeaders
  FROM
    `httparchive.summary_requests.2025_07_01_*`
),

third_party AS (
  SELECT
    domain,
    category,
    COUNT(DISTINCT page) AS page_usage
  FROM
    `httparchive.almanac.third_parties` tp
  JOIN
    requests r
  ON NET.HOST(r.url) = NET.HOST(tp.domain)
  WHERE
    date = '2025-07-01' AND
    category != 'hosting'
  GROUP BY
    domain,
    category
  HAVING
    page_usage >= 50
),

headers AS (
  SELECT
    client,
    requests.origin AS req_origin,
    LOWER(respOtherHeaders) AS respOtherHeaders,
    third_party.category AS req_category
  FROM requests
  INNER JOIN third_party
  ON NET.HOST(requests.origin) = NET.HOST(third_party.domain)
),

base AS (
  SELECT
    client,
    req_origin,
    req_category,
    IF(STRPOS(respOtherHeaders, 'strict-transport-security') > 0, 1, 0) AS hsts_header,
    IF(STRPOS(respOtherHeaders, 'x-content-type-options') > 0, 1, 0) AS x_content_type_options_header,
    IF(STRPOS(respOtherHeaders, 'x-frame-options') > 0, 1, 0) AS x_frame_options_header,
    IF(STRPOS(respOtherHeaders, 'x-xss-protection') > 0, 1, 0) AS x_xss_protection_header
  FROM headers
)

SELECT
  client,
  req_category,
  COUNT(0) AS total_requests,
  SUM(hsts_header) / COUNT(0) AS pct_hsts_header_requests,
  SUM(x_content_type_options_header) / COUNT(0) AS pct_x_content_type_options_header_requests,
  SUM(x_frame_options_header) / COUNT(0) AS pct_x_frame_options_header_requests,
  SUM(x_xss_protection_header) / COUNT(0) AS pct_x_xss_protection_header_requests
FROM
  base
GROUP BY
  client,
  req_category
ORDER BY
  client,
  req_category
