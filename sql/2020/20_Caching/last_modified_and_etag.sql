#standardSQL
# Presence of Last-Modified and ETag header, statistics on weak, strong, and invalid ETag.
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(uses_no_etag) AS total_no_etag,
  COUNTIF(uses_etag) AS total_etag,
  COUNTIF(uses_weak_etag) AS total_weak_etag,
  COUNTIF(uses_strong_etag) AS total_strong_etag,
  COUNTIF(NOT uses_weak_etag AND NOT uses_strong_etag AND uses_etag) AS total_invalid_etag,
  COUNTIF(uses_last_modified) AS total_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) AS total_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) AS total_using_neither,
  COUNTIF(uses_no_etag) * 100 / COUNT(0) AS pct_no_etag,
  COUNTIF(uses_etag) * 100 / COUNT(0) AS pct_etag,
  COUNTIF(uses_weak_etag) * 100 / COUNT(0) AS pct_weak_etag,
  COUNTIF(uses_strong_etag) * 100 / COUNT(0) AS pct_strong_etag,
  COUNTIF(NOT uses_weak_etag AND NOT uses_strong_etag AND uses_etag) * 100 / COUNT(0) AS pct_invalid_etag,
  COUNTIF(uses_last_modified) * 100 / COUNT(0) AS pct_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) * 100 / COUNT(0) AS pct_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) * 100 / COUNT(0) AS pct_using_neither
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_etag) = "" AS uses_no_etag,
    TRIM(resp_etag) != "" AS uses_etag,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    REGEXP_CONTAINS(TRIM(resp_etag), '^W/\".*\"') AS uses_weak_etag,
    REGEXP_CONTAINS(TRIM(resp_etag), '^\".*\"') AS uses_strong_etag
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
