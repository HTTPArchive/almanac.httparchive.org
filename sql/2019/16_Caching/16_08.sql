#standardSQL
# 16_08: Use of Cache-Control: max-age vs. Expires
SELECT
  client,
  COUNT(0) AS total_requests,

  COUNTIF(uses_max_age) AS max_age_count,
  COUNTIF(uses_expires) AS expires_count,
  COUNTIF(uses_max_age AND uses_expires) AS uses_both_count,
  COUNTIF(NOT uses_max_age AND NOT uses_expires) AS uses_neither,

  ROUND(COUNTIF(uses_max_age) * 100 / COUNT(0), 2) AS pct_max_age,
  ROUND(COUNTIF(uses_expires) * 100 / COUNT(0), 2) AS pct_expires,
  ROUND(COUNTIF(uses_max_age AND uses_expires) * 100 / COUNT(0), 2) AS pct_uses_both,
  ROUND(COUNTIF(NOT uses_max_age AND NOT uses_expires) * 100 / COUNT(0), 2) AS pct_uses_neither
FROM (
  SELECT
    client,
    TRIM(resp_expires) = "" AS uses_expires,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=') AS uses_max_age
  FROM
    `httparchive.almanac.requests`
)
GROUP BY
  client
