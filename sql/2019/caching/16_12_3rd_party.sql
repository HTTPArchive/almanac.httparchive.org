#standardSQL
# 16_12_3rd_party: Public vs Private by party
SELECT
  client,
  party,
  COUNT(0) AS total_requests,

  COUNTIF(uses_cache_control) AS total_using_control,
  COUNTIF(uses_public) AS total_public,
  COUNTIF(uses_private) AS total_private,
  COUNTIF(uses_public AND uses_private) AS total_using_both,

  ROUND(COUNTIF(uses_cache_control) * 100 / COUNT(0), 2) AS pct_req_using_control,
  ROUND(COUNTIF(uses_public) * 100 / COUNTIF(uses_cache_control), 2) AS pct_control_using_public,
  ROUND(COUNTIF(uses_private) * 100 / COUNTIF(uses_cache_control), 2) AS pct_control_using_private,
  ROUND(COUNTIF(uses_public AND uses_private) * 100 / COUNTIF(uses_cache_control), 2) AS pct_control_using_both
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    TRIM(resp_cache_control) != "" AS uses_cache_control,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)(^\s*|,\s*)public(\s*,|\s*$)') AS uses_public,
    REGEXP_CONTAINS(resp_cache_control, r'(?i)(^\s*|,\s*)private(\s*,|\s*$)') AS uses_private
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
