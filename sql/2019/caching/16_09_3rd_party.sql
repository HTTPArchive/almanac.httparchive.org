#standardSQL
# 16_09_3rd_party: Use of Vary (how many dimensions, what headers, etc.) by party
SELECT
  client,
  party,
  all_requests,
  total_with_vary,
  header_name,
  COUNT(0) AS occurrences,
  ROUND(COUNT(0) * 100 / total_with_vary, 2) AS pct_of_vary,
  ROUND(COUNT(0) * 100 / all_requests, 2) AS pct_all_requests
FROM (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    resp_vary
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
),
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS header_name
JOIN (
  SELECT
    client,
    IF(STRPOS(NET.HOST(url), REGEXP_EXTRACT(NET.REG_DOMAIN(page), r'([\w-]+)')) > 0, 1, 3) AS party,
    COUNT(0) AS all_requests,
    COUNTIF(TRIM(resp_vary) != '') AS total_with_vary
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2019-07-01'
  GROUP BY
    client,
    party
)
USING (date, client, party)
GROUP BY
  client,
  all_requests,
  total_with_vary,
  header_name,
  party
ORDER BY
  occurrences DESC
