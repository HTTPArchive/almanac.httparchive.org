#standardSQL
# 16_10: Use of other Cache-Control directives (e.g., public, private, immutable)
SELECT
  client,
  all_requests,
  total_using_control,
  header_name,
  COUNT(0) AS occurrences,
  ROUND(COUNT(0) * 100 / total_using_control, 2) AS pct_of_control,
  ROUND(COUNT(0) * 100 / all_requests, 2) AS pct_all_requests
FROM
  `httparchive.almanac.requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_cache_control), r'([a-z][^,\s="\']*)')) AS header_name
JOIN (
  SELECT
    client,
    COUNT(0) AS all_requests,
    COUNTIF(TRIM(resp_cache_control) != "") AS total_using_control
  FROM
    `httparchive.almanac.requests`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  all_requests,
  total_using_control,
  header_name
ORDER BY
  occurrences DESC
