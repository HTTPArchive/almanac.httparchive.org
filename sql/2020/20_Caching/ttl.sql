#standardSQL
# TTL statistics for cacheable content (no-store absent)
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither,
  COUNTIF(uses_no_store) AS total_using_no_store,
  COUNTIF(NOT uses_no_store AND exp_age = 0) AS total_exp_age_zero,
  COUNTIF(NOT uses_no_store AND exp_age > 0) AS total_exp_age_gt_zero,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_neither,
  COUNTIF(uses_no_store) / COUNT(0) AS pct_using_no_store,  
  COUNTIF(NOT uses_no_store AND exp_age = 0) / COUNT(0) AS pct_using_exp_age_zero,
  COUNTIF(NOT uses_no_store AND exp_age > 0) / COUNT(0) AS pct_using_exp_age_gt_zero
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    TRIM(resp_expires) != "" AS uses_expires,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AS uses_no_store,
    expAge AS exp_age
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
