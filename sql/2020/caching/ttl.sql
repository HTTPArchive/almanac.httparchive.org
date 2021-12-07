#standardSQL
# TTL statistics for cacheable content (no-store absent)
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age = 0) AS total_exp_age_zero,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age > 0) AS total_exp_age_gt_zero,
  COUNTIF(uses_no_store) AS total_not_cacheable,
  COUNTIF(NOT uses_no_store) AS total_cacheable,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNTIF(NOT uses_no_store) AS pct_using_neither,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age = 0) / COUNTIF(NOT uses_no_store) AS pct_using_exp_age_zero,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age > 0) / COUNTIF(NOT uses_no_store) AS pct_using_exp_age_gt_zero,
  COUNTIF(uses_no_store) / COUNT(0) AS pct_not_cacheable,
  COUNTIF(NOT uses_no_store) / COUNT(0) AS pct_cacheable
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    TRIM(resp_expires) != "" AS uses_expires,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AS uses_no_store,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=\s*[0-9]+') AS uses_max_age,
    expAge AS exp_age
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
