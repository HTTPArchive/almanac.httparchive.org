#standardSQL
# 16_05_3rd_party: Availability of Last-Modified vs. ETag validators by party
SELECT
  client,
  party,
  COUNT(0) AS total_requests,

  COUNTIF(uses_etag) AS total_etag,
  COUNTIF(uses_last_modified) AS total_last_modified,
  COUNTIF(uses_etag AND uses_last_modified) AS total_using_both,
  COUNTIF(NOT uses_etag AND NOT uses_last_modified) AS total_using_neither,

  ROUND(COUNTIF(uses_etag) * 100 / COUNT(0), 2) AS pct_etag,
  ROUND(COUNTIF(uses_last_modified) * 100 / COUNT(0), 2) AS pct_last_modified,
  ROUND(COUNTIF(uses_etag AND uses_last_modified) * 100 / COUNT(0), 2) AS pct_uses_both,
  ROUND(COUNTIF(NOT uses_etag AND NOT uses_last_modified) * 100 / COUNT(0), 2) AS pct_uses_neither
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    TRIM(resp_etag) != "" AS uses_etag,
    TRIM(resp_last_modified) != "" AS uses_last_modified
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
)
GROUP BY
  client,
  party
ORDER BY
  client,
  party
