#standardSQL
# Section: Attack preventions - Security Headers? (document.domain feature)
# Question: How often is document.domain still used even though deprecated?
# Note: Possible to port to httparchive.all.pages, however would require to recreate num_urls, total_urls, and pct_urls
# Note: Features here: https://source.chromium.org/chromium/chromium/src/+/main:third_party/blink/renderer/core/dom/document.cc?q=DocumentSetDomain
# Note: DocumentDomainSettingWithoutOriginAgentClusterHeader seems broken as the OAC header is very rare and yet the difference between DocumentSetDomain and DocumentDomainSettingWithoutOriginAgentClusterHeader is large (Explanation: from '20230201' they count no header as header exist.)
SELECT
  client,
  feature,
  num_urls,
  total_urls,
  pct_urls
FROM
  `httparchive.blink_features.usage`
WHERE
  yyyymmdd = '20250701' AND
  feature IN UNNEST(['DocumentSetDomain', 'DocumentDomainSettingWithoutOriginAgentClusterHeader', 'DocumentDomainSetWithDefaultPort', 'DocumentDomainSetWithNonDefaultPort', 'CrossOriginAccessBasedOnDocumentDomain', 'DocumentDomainEnabledCrossOriginAccess', 'DocumentDomainBlockedCrossOriginAccess', 'DocumentOpenAliasedOriginDocumentDomain'])
ORDER BY
  pct_urls DESC
