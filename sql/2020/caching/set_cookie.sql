#standardSQL
# Responses with Set-cookie header, absence of no-store means cacheable (max-age, Expires, or heuristic)
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(NOT uses_no_store) AS total_cacheable,
  COUNTIF(NOT uses_no_store AND uses_cookies) AS total_cacheable_set_cookie,
  COUNTIF(NOT uses_no_store AND NOT uses_cookies) AS total_cacheable_without_set_cookie,
  COUNTIF(NOT uses_no_store AND uses_cookies AND uses_private) AS total_pvt_cacheable_set_cookie,
  COUNTIF(NOT uses_no_store AND uses_cookies AND NOT uses_private) AS total_pvt_public_cacheable_set_cookie,
  COUNTIF(NOT uses_no_store AND uses_cookies) / COUNTIF(NOT uses_no_store) AS pct_cacheable_set_cookie,
  COUNTIF(NOT uses_no_store AND NOT uses_cookies) / COUNTIF(NOT uses_no_store) AS pct_cacheable_without_set_cookie,
  COUNTIF(NOT uses_no_store AND uses_cookies AND uses_private) / COUNTIF(NOT uses_no_store AND uses_cookies) AS pct_pvt_cacheable_set_cookie,
  COUNTIF(NOT uses_no_store AND uses_cookies AND NOT uses_private) / COUNTIF(NOT uses_no_store AND uses_cookies) AS pct_pvt_public_cacheable_set_cookie
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AS uses_no_store,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)private') AS uses_private,
    (reqCookieLen > 0) AS uses_cookies
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
