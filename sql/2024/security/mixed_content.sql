#standardSQL
# Section: Transport Security - ?
# Question: How many landing pages that load over HTTPS have at least one reference over HTTP? (Distributed across ranking)
# Note: Each rank bucket does not include lower buckets;
# Prevalence of landing pages over HTTPS that include at least one reference over HTTP, and distribution over ranking
SELECT
  client,
  rank AS rank_grouping,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') THEN page END)) AS total_pages_over_https,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) AS count_pages_over_https_with_http_reference,
  COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') AND REGEXP_CONTAINS(url, r'http://.*') THEN page END)) / COUNT(DISTINCT(CASE WHEN REGEXP_CONTAINS(page, r'https://.*') THEN page END)) AS pct_pages_over_https_with_http_reference
FROM
  `httparchive.all.requests`
JOIN
  `httparchive.all.pages` USING (client, page, date, is_root_page)
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client,
  rank
ORDER BY
  client,
  rank_grouping
