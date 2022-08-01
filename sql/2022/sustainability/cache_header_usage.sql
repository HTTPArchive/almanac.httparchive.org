#standardSQL
# The distribution of cache header adoption on websites by percentile and client.
WITH summary_requests AS (
  SELECT
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_requests.2022_06_01_*`
)

SELECT
  client,
  percentile,
  COUNT(0) AS total_requests,

  COUNTIF(uses_cache_control) AS total_using_cache_control,
  COUNTIF(uses_max_age) AS total_using_max_age,
  COUNTIF(uses_expires) AS total_using_expires,
  COUNTIF(uses_max_age AND uses_expires) AS total_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) AS total_using_both,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither,
  COUNTIF(uses_cache_control AND NOT uses_expires) AS total_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) AS total_using_only_expires,

  COUNTIF(uses_cache_control) / COUNT(0) AS pct_cache_control,
  COUNTIF(uses_max_age) / COUNT(0) AS pct_using_max_age,
  COUNTIF(uses_expires) / COUNT(0) AS pct_using_expires,
  COUNTIF(uses_max_age AND uses_expires) / COUNT(0) AS pct_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_both,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_neither,
  COUNTIF(uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_only_expires,
FROM (
  SELECT
    client,
    percentile,
    TRIM(resp_expires) != '' AS uses_expires,
    TRIM(resp_cache_control) != '' AS uses_cache_control,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=\s*[0-9]+') AS uses_max_age,
    TRIM(resp_etag) = '' AS uses_no_etag,
    TRIM(resp_etag) != '' AS uses_etag,
    TRIM(resp_last_modified) != '' AS uses_last_modified,
    REGEXP_CONTAINS(TRIM(resp_etag), '^W/".*"') AS uses_weak_etag,
    REGEXP_CONTAINS(TRIM(resp_etag), '^".*"') AS uses_strong_etag
  FROM
    summary_requests,
    UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
)
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
