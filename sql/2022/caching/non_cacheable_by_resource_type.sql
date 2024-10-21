#standardSQL
# Non-cacheable content (no-store present) by resource type
SELECT
  client,
  resource_type,
  COUNT(0) AS total_requests,
  COUNTIF(NOT uses_no_store) AS total_cacheable,
  COUNTIF(uses_no_store) AS total_non_cacheable,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age = 0) AS total_exp_age_zero,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age > 0) AS total_exp_age_gt_zero,
  COUNTIF(NOT uses_no_store) / COUNT(0) AS pct_cacheable,
  COUNTIF(uses_no_store) / COUNT(0) AS pct_non_cacheable,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNTIF(NOT uses_no_store) AS pct_using_neither,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age = 0) / COUNTIF(NOT uses_no_store) AS pct_using_exp_age_zero,
  COUNTIF(NOT uses_no_store AND uses_max_age AND exp_age > 0) / COUNTIF(NOT uses_no_store) AS pct_using_exp_age_gt_zero
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    type AS resource_type,
    TRIM(resp_cache_control) != '' AS uses_cache_control,
    TRIM(resp_expires) != '' AS uses_expires,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AS uses_no_store,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=\s*[0-9]+') AS uses_max_age,
    expAge AS exp_age
  FROM
    `httparchive.summary_requests.2022_06_01_*`
)
GROUP BY
  client,
  resource_type
ORDER BY
  client,
  resource_type
