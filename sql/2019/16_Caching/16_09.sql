#standardSQL
# 16_09: Use of Vary (how many dimensions, what headers, etc.)
SELECT
  client,
  all_requests,
  total_with_vary,
  header_name,
  COUNT(0) AS occurrences,
  ROUND(COUNT(0) * 100 / total_with_vary, 2) AS pct_of_vary,
  ROUND(COUNT(0) * 100 / all_requests, 2) AS pct_all_requests
FROM
  `httparchive.almanac.requests`,
  UNNEST(REGEXP_EXTRACT_ALL(LOWER(resp_vary), r'([a-z][^,\s="\']*)')) AS header_name
JOIN (
  SELECT
    client,
    COUNT(0) AS all_requests,
    COUNTIF(TRIM(resp_vary) != "") AS total_with_vary
  FROM
    `httparchive.almanac.requests`
  GROUP BY
    client
)
USING (client)
GROUP BY
  client,
  all_requests,
  total_with_vary,
  header_name
ORDER BY
  occurrences DESC
