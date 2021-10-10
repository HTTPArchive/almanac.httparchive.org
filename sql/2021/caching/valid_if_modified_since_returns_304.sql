#standardSQL
# Whether making a If-Modified-Since request returns a 304 if the content have not changed (as seen from Last-Modified)
SELECT
  client,
  COUNT(0) AS total_requests,
  COUNTIF(status = 304) AS total_304,
  COUNTIF(NOT uses_etag AND uses_last_modified AND uses_if_modified AND no_change) AS total_expected_304,
  COUNTIF(NOT uses_etag AND uses_last_modified AND uses_if_modified AND no_change AND status = 304) AS total_actual_304,
  COUNTIF(status = 304) / COUNT(0) AS pct_304,
  COUNTIF(NOT uses_etag AND uses_last_modified AND uses_if_modified AND no_change) / COUNTIF(status = 304) AS pct_expected_304,
  COUNTIF(NOT uses_etag AND uses_last_modified AND uses_if_modified AND no_change AND status = 304) / COUNTIF(NOT uses_etag AND uses_last_modified AND uses_if_modified AND no_change) AS pct_actual_304
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    status,
    TRIM(resp_last_modified) = TRIM(req_if_modified_since) AS no_change,
    TRIM(resp_last_modified) != "" AS uses_last_modified,
    TRIM(req_if_modified_since) != "" AS uses_if_modified,
    TRIM(resp_etag) != "" AS uses_etag
  FROM
    `httparchive.summary_requests.2021_07_01_*`
)
GROUP BY
  client
ORDER BY
  client
