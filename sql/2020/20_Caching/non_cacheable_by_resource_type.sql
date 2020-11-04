#standardSQL
# Non-cacheable content (no-store present) by resource type
SELECT
  client,
  resource_type,
  COUNT(0) AS total_requests,
  COUNTIF(uses_cache_control AND uses_no_store) AS total_non_cacheable,
  COUNTIF(uses_cache_control AND uses_no_store) / COUNT(0) AS pct_non_cacheable
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    type AS resource_type,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)no-store') AS uses_no_store
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client,
  resource_type
ORDER BY
  client,
  resource_type
  