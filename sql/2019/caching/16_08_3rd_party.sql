#standardSQL
# 16_08_3rd_party: Use of Cache-Control: max-age vs. Expires by party
SELECT
  client,
  party,
  COUNT(0) AS total_requests,

  COUNTIF(uses_max_age) AS total_max_age,
  COUNTIF(uses_expires) AS total_expires,
  COUNTIF(uses_max_age AND uses_expires) AS total_using_both,
  COUNTIF(NOT uses_max_age AND NOT uses_expires) AS total_using_neither,

  ROUND(COUNTIF(uses_max_age) * 100 / COUNT(0), 2) AS pct_max_age,
  ROUND(COUNTIF(uses_expires) * 100 / COUNT(0), 2) AS pct_expires,
  ROUND(COUNTIF(uses_max_age AND uses_expires) * 100 / COUNT(0), 2) AS pct_uses_both,
  ROUND(COUNTIF(NOT uses_max_age AND NOT uses_expires) * 100 / COUNT(0), 2) AS pct_uses_neither
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    TRIM(resp_expires) != "" AS uses_expires,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)max-age\s*=') AS uses_max_age
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
