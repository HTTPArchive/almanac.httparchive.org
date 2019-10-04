#standardSQL
# 16_13: Use of must-revalidate
SELECT
  client,
  COUNT(0) AS total_requests,

  COUNTIF(uses_cache_control) AS total_using_control,
  COUNTIF(uses_revalidate) AS total_revalidate,

  ROUND(COUNTIF(uses_cache_control) * 100 / COUNT(0), 2) AS pct_req_using_control,
  ROUND(COUNTIF(uses_revalidate) * 100 / COUNTIF(uses_cache_control), 2) AS pct_control_using_revalidate
FROM (
  SELECT
    client,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)(^\s*|,\s*)must-revalidate(\s*,|\s*$)') AS uses_revalidate
  FROM
    `httparchive.almanac.requests`
)
GROUP BY
  client
