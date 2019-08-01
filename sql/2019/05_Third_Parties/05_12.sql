#standardSQL
# Percentile breakdown page-relative percentage of total bytes that are from third party requests broken down by third party category.
SELECT
  COUNT(*) as numberOfPages,
  APPROX_QUANTILES(numberOfThirdPartyBytes / numberOfBytes, 100) AS percentThirdPartyBytesQuantiles,
  APPROX_QUANTILES(numberOfAdBytes / numberOfBytes, 100) AS percentAdBytesQuantiles,
  APPROX_QUANTILES(numberOfAnalyticsBytes / numberOfBytes, 100) as percentAnalyticsBytesQuantiles,
  APPROX_QUANTILES(numberOfSocialBytes / numberOfBytes, 100) as percentSocialBytesQuantiles,
  APPROX_QUANTILES(numberOfVideoBytes / numberOfBytes, 100) as percentVideoBytesQuantiles,
  APPROX_QUANTILES(numberOfUtilityBytes / numberOfBytes, 100) as percentUtilityBytesQuantiles,
  APPROX_QUANTILES(numberOfHostingBytes / numberOfBytes, 100) as percentHostingBytesQuantiles,
  APPROX_QUANTILES(numberOfMarketingBytes / numberOfBytes, 100) as percentMarketingBytesQuantiles,
  APPROX_QUANTILES(numberOfCustomerSuccessBytes / numberOfBytes, 100) as percentCustomerSuccessBytesQuantiles,
  APPROX_QUANTILES(numberOfContentBytes / numberOfBytes, 100) as percentContentBytesQuantiles,
  APPROX_QUANTILES(numberOfCdnBytes / numberOfBytes, 100) as percentCdnBytesQuantiles,
  APPROX_QUANTILES(numberOfTagManagerBytes / numberOfBytes, 100) as percentTagManagerBytesQuantiles,
  APPROX_QUANTILES(numberOfOtherBytes / numberOfBytes, 100) as percentOtherBytesQuantiles
FROM (
  SELECT
    pageUrl,
    COUNT(*) as numberOfRequests,
    SUM(requestBytes) AS numberOfBytes,
    SUM(IF(thirdPartyDomain IS NULL, requestBytes, 0)) AS numberOfFirstPartyBytes,
    SUM(IF(thirdPartyDomain IS NOT NULL, requestBytes, 0)) AS numberOfThirdPartyBytes,
    SUM(IF(thirdPartyCategory = 'ad', requestBytes, 0)) AS numberOfAdBytes,
    SUM(IF(thirdPartyCategory = 'analytics', requestBytes, 0)) as numberOfAnalyticsBytes,
    SUM(IF(thirdPartyCategory = 'social', requestBytes, 0)) as numberOfSocialBytes,
    SUM(IF(thirdPartyCategory = 'video', requestBytes, 0)) as numberOfVideoBytes,
    SUM(IF(thirdPartyCategory = 'utility', requestBytes, 0)) as numberOfUtilityBytes,
    SUM(IF(thirdPartyCategory = 'hosting', requestBytes, 0)) as numberOfHostingBytes,
    SUM(IF(thirdPartyCategory = 'marketing', requestBytes, 0)) as numberOfMarketingBytes,
    SUM(IF(thirdPartyCategory = 'customer-success', requestBytes, 0)) as numberOfCustomerSuccessBytes,
    SUM(IF(thirdPartyCategory = 'content', requestBytes, 0)) as numberOfContentBytes,
    SUM(IF(thirdPartyCategory = 'cdn', requestBytes, 0)) as numberOfCdnBytes,
    SUM(IF(thirdPartyCategory = 'tag-manager', requestBytes, 0)) as numberOfTagManagerBytes,
    SUM(IF(thirdPartyCategory = 'other', requestBytes, 0)) as numberOfOtherBytes
  FROM (
    SELECT
      page AS pageUrl,
      respBodySize AS requestBytes,
      DomainsOver50Table.requestDomain as thirdPartyDomain,
      ThirdPartyTable.category as thirdPartyCategory
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
  )
  GROUP BY
    pageUrl
)
