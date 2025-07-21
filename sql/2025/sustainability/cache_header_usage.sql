#standardSQL
# The distribution of cache header adoption on websites by client.

SELECT
  client,
  COUNT(0) AS total_requests,

  COUNTIF(uses_cache_control) AS total_using_cache_control,
  COUNTIF(uses_max_age) AS total_using_max_age,
  COUNTIF(uses_expires) AS total_using_expires,
  COUNTIF(uses_max_age AND uses_expires) AS total_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) AS total_using_both_cc_and_expires,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) AS total_using_neither_cc_and_expires,
  COUNTIF(uses_cache_control AND NOT uses_expires) AS total_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) AS total_using_only_expires,

  COUNTIF(uses_cache_control) / COUNT(0) AS pct_cache_control,
  COUNTIF(uses_max_age) / COUNT(0) AS pct_using_max_age,
  COUNTIF(uses_expires) / COUNT(0) AS pct_using_expires,
  COUNTIF(uses_max_age AND uses_expires) / COUNT(0) AS pct_using_max_age_and_expires,
  COUNTIF(uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_both_cc_and_expires,
  COUNTIF(NOT uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_neither_cc_nor_expires,
  COUNTIF(uses_cache_control AND NOT uses_expires) / COUNT(0) AS pct_using_only_cache_control,
  COUNTIF(NOT uses_cache_control AND uses_expires) / COUNT(0) AS pct_using_only_expires

FROM (
  SELECT
    client,

    JSON_EXTRACT_SCALAR(summary, '$.resp_expires') IS NOT NULL AND TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_expires')) != '' AS uses_expires,
    JSON_EXTRACT_SCALAR(summary, '$.resp_cache_control') IS NOT NULL AND TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_cache_control')) != '' AS uses_cache_control,
    REGEXP_CONTAINS(JSON_EXTRACT_SCALAR(summary, '$.resp_cache_control'), r'(?i)max-age\s*=\s*[0-9]+') AS uses_max_age,

    JSON_EXTRACT_SCALAR(summary, '$.resp_etag') IS NULL OR TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_etag')) = '' AS uses_no_etag,
    JSON_EXTRACT_SCALAR(summary, '$.resp_etag') IS NOT NULL AND TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_etag')) != '' AS uses_etag,
    JSON_EXTRACT_SCALAR(summary, '$.resp_last_modified') IS NOT NULL AND TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_last_modified')) != '' AS uses_last_modified,

    REGEXP_CONTAINS(TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_etag')), '^W/".*"') AS uses_weak_etag,
    REGEXP_CONTAINS(TRIM(JSON_EXTRACT_SCALAR(summary, '$.resp_etag')), '^".*"') AS uses_strong_etag

  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-06-01'
)

GROUP BY
  client
ORDER BY
  client; 