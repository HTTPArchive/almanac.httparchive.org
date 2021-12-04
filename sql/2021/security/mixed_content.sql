#standardSQL
# Prevalence of landing pages over HTTPS that include at least one reference over HTTP, and distribution over ranking
SELECT
  client,
  rank_grouping,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') THEN page END)) AS total_pages_over_https,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) AS count_pages_over_https_with_http_reference,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') THEN page END)) AS pct_pages_over_https_with_http_reference
FROM
  `httparchive.almanac.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
WHERE
  date = '2021-07-01' AND
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
