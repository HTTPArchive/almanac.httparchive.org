#standardSQL
# 16_02_3rd_party: Resources served without cache by party
SELECT
  client,
  COUNT(0) AS total_requests,
  party,
  type,
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
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)(no-cache|no-store)') AS not_cacheable,
    expAge > 0 AS uses_cache
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
)
GROUP BY
  client,
  type,
  party
ORDER BY
  type,
  client,
  party
