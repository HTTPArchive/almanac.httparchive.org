#standardSQL
# Presence of Last-Modified and ETag header, statistics on weak, strong, and invalid ETag.
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(uses_no_etag) AS no_etag,
  COUNTIF(uses_etag) AS total_etag,
  COUNTIF(weak_etag) AS total_weak_etag,
  COUNTIF(strong_etag) AS total_strong_etag,
  COUNTIF(NOT weak_etag AND NOT strong_etag AND uses_etag) AS total_invalid_etag,
  COUNTIF(uses_last_modified) AS total_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) AS total_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) AS total_using_neither,
  COUNTIF(uses_no_etag) * 100 / COUNT(0) AS pct_noetag,
  COUNTIF(uses_etag) * 100 / COUNT(0) AS pct_etag,
  COUNTIF(weak_etag) * 100 / COUNT(0) AS pct_weak_etag,
  COUNTIF(strong_etag) * 100 / COUNT(0) AS pct_strong_etag,
  COUNTIF(NOT weak_etag AND NOT strong_etag AND uses_etag) * 100 / COUNT(0) AS pct_invalid_etag,
  COUNTIF(uses_last_modified) * 100 / COUNT(0) AS pct_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) * 100 / COUNT(0) AS pct_uses_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) * 100 / COUNT(0) AS pct_uses_neither
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    TRIM(resp_etag) = "" AS uses_no_etag,
    TRIM(resp_etag) != "" AS uses_etag,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    REGEXP_CONTAINS(TRIM(resp_etag), '^W/\".*\"') AS weak_etag,
    REGEXP_CONTAINS(TRIM(resp_etag), '^\".*\"') AS strong_etag
  FROM
    `httparchive.summary_requests.2020_08_01_*`
)
GROUP BY
  client
