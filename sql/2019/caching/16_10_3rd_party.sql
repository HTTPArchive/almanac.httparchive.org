#standardSQL
# 16_10_3rd_party: Use of other Cache-Control directives (e.g., public, private, immutable) by party
SELECT
  client,
  party,
  all_requests,
  total_using_control,
  directive,
  COUNT(0) AS occurrences,
  ROUND(COUNT(0) * 100 / total_using_control, 2) AS pct_of_control,
  ROUND(COUNT(0) * 100 / all_requests, 2) AS pct_all_requests
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    resp_cache_control
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
),
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_cache_control), r'([a-z][^,\s="\']*)')) AS directive
JOIN (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    COUNT(0) AS all_requests,
    COUNTIF(TRIM(resp_cache_control) != '') AS total_using_control
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    party
)
USING (client, party)
GROUP BY
  client,
  all_requests,
  total_using_control,
  directive,
  party
ORDER BY
  occurrences DESC
