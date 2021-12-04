#standardSQL
# Use of Cache-Control, max-age in Cache-Control, and Expires
WITH summary_requests AS (
  SELECT
    '2019' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_requests.2019_07_01_*`
  UNION ALL
  SELECT
    '2020' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_requests.2020_08_01_*`
  UNION ALL
  SELECT
    '2021' AS year,
    _TABLE_SUFFIX AS client,
    *
  FROM
    `httparchive.summary_requests.2021_07_01_*`
)

SELECT
  year,
  client,
  COUNT(0) AS total_requests,

  COUNTIF(uses_cache_control) AS total_using_cache_control,
  COUNTIF(uses_max_age) AS total_using_max_age,
  COUNTIF(uses_expires) AS total_using_expires,
  COUNTIF(uses_max_age AND uses_expires) AS total_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) AS total_using_both,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither,
  COUNTIF(uses_cache_control AND NOT uses_expires) AS total_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) AS total_using_only_expires,

  COUNTIF(uses_no_etag) AS total_using_no_etag,
  COUNTIF(uses_etag) AS total_using_etag,
  COUNTIF(uses_weak_etag) AS total_using_weak_etag,
  COUNTIF(uses_strong_etag) AS total_using_strong_etag,
  COUNTIF(NOT uses_weak_etag AND NOT uses_strong_etag AND uses_etag) AS total_using_invalid_etag,
  COUNTIF(uses_last_modified) AS total_using_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) AS total_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) AS total_using_neither,

  COUNTIF(uses_cache_control) / COUNT(0) AS pct_cache_control,
  COUNTIF(uses_max_age) / COUNT(0) AS pct_using_max_age,
  COUNTIF(uses_expires) / COUNT(0) AS pct_using_expires,
  COUNTIF(uses_max_age AND uses_expires) / COUNT(0) AS pct_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_both,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_neither,
  COUNTIF(uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_only_expires,

  COUNTIF(uses_no_etag) / COUNT(0) AS pct_using_no_etag,
  COUNTIF(uses_etag) / COUNT(0) AS pct_using_etag,
  COUNTIF(uses_weak_etag) / COUNT(0) AS pct_using_weak_etag,
  COUNTIF(uses_strong_etag) / COUNT(0) AS pct_using_strong_etag,
  COUNTIF(NOT uses_weak_etag AND NOT uses_strong_etag AND uses_etag) / COUNT(0) AS pct_using_invalid_etag,
  COUNTIF(uses_last_modified) / COUNT(0) AS pct_using_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) / COUNT(0) AS pct_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) / COUNT(0) AS pct_using_neither
FROM (
  SELECT
    year,
    client,
    TRIM(resp_expires) != "" AS uses_expires,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=\s*[0-9]+') AS uses_max_age,
    TRIM(resp_etag) = "" AS uses_no_etag,
    TRIM(resp_etag) != "" AS uses_etag,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    REGEXP_CONTAINS(TRIM(resp_etag), '^W/\".*\"') AS uses_weak_etag,
    REGEXP_CONTAINS(TRIM(resp_etag), '^\".*\"') AS uses_strong_etag
  FROM
    summary_requests
)
GROUP BY
  year,
  client
ORDER BY
  year,
  client
