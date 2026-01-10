#standardSQL
# Section: Attack preventions - Security Headers? (document.domain feature)
# Question: How often is document.domain still used even though deprecated?
# Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
# Note: Features here: https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/core/dom/document.cc?q=DocumentSetDomain
# Note: DocumentDomainSettingWithoutOriginAgentClusterHeader seems broken as the OAC header is very rare and yet the difference between DocumentSetDomain and DocumentDomainSettingWithoutOriginAgentClusterHeader is large (Explanation: from '20230201' they count no header as header exist.)
SELECT
  client,
  featurename,
  COUNT(DISTINCT page) AS total_pages,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) AS count_with_feature,
  COUNT(DISTINCT IF(LOWER(feature) = LOWER(featurename), page, NULL)) / COUNT(DISTINCT page) AS pct_with_feature
FROM (
  SELECT
    client,
    page,
    features.feature AS feature
  FROM
    `httparchive.crawl.pages`,
    UNNEST(features) AS features
  WHERE
    date = '2025-07-01'
),
  UNNEST([
    'DocumentSetDomain',
    'DocumentDomainSettingWithoutOriginAgentClusterHeader',
    'DocumentDomainSetWithDefaultPort',
    'DocumentDomainSetWithNonDefaultPort',
    'CrossOriginAccessBasedOnDocumentDomain',
    'DocumentDomainEnabledCrossOriginAccess',
    'DocumentDomainBlockedCrossOriginAccess',
    'DocumentOpenAliasedOriginDocumentDomain'
  ]) AS featurename
GROUP BY
  client,
  featurename
ORDER BY
  client,
  featurename
