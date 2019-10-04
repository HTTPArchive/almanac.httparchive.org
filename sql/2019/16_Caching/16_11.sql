#standardSQL
# 16_02: Resources served without cache
SELECT
  client,
  COUNT(0) AS total_requests,
  type,
  party,

  COUNTIF(not_cacheable) AS total_not_cacheable,
  COUNTIF(NOT not_cacheable AND uses_cache) AS total_using_cache,
  COUNTIF(NOT not_cacheable AND NOT uses_cache) AS total_not_using_cache,

  ROUND(COUNTIF(not_cacheable) * 100 / COUNT(0), 2) AS perc_not_cacheable,
  ROUND(COUNTIF(NOT not_cacheable AND uses_cache) * 100 / COUNT(0), 2) AS perc_using_cache,
  ROUND(COUNTIF(NOT not_cacheable AND NOT uses_cache) * 100 / COUNT(0), 2) AS perc_not_using_cache
FROM (
  SELECT
    client,
    type,
    --- If the request url's host does not contain the domain of the request page, this is most likely a 3rd party resource
    IF (STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,

    REGEXP_CONTAINS(resp_cache_control, r'(?i)(no-cache|no-store)') AS not_cacheable,
    expAge > 0 AS uses_cache
  FROM
    `httparchive.almanac.requests`
)
GROUP BY
  client,
  party,
  type
ORDER BY
  type,
  client,
  party
