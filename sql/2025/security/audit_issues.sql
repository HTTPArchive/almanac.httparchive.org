#standardSQL
# Question: What Audit issues are present in the pages? https://chromedevtools.github.io/devtools-protocol/tot/Audits/#type-InspectorIssueCode
SELECT
  client,
  issuename,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(LOWER(JSON_VALUE(issue.code)) = LOWER(issuename), page, NULL)) AS count_with_issue,
  COUNT(DISTINCT IF(LOWER(JSON_VALUE(issue.code)) = LOWER(issuename), page, NULL)) / COUNT(DISTINCT page) AS pct_with_issue
FROM
  `httparchive.crawl.pages`,
  UNNEST(JSON_QUERY_ARRAY(payload._audit_issues)) AS issue,
  UNNEST([
    'CookieIssue',
    'MixedContentIssue',
    'ContentSecurityPolicyIssue',
    'CorsIssue'
  ]) AS issuename
WHERE
  date = '2025-07-01' AND
  is_root_page
GROUP BY
  client,
  issuename
ORDER BY
  client,
  pct_with_issue DESC
