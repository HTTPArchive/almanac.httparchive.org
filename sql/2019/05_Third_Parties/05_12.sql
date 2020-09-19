#standardSQL
# Percentile breakdown page-relative percentage of total bytes that are from third party requests broken down by third party category.
SELECT
  client,
  COUNT(0) AS numberOfPages,
  APPROX_QUANTILES(numberOfThirdPartyBytes / numberOfBytes, 100) AS percentThirdPartyBytesQuantiles,
  APPROX_QUANTILES(numberOfAdBytes / numberOfBytes, 100) AS percentAdBytesQuantiles,
  APPROX_QUANTILES(numberOfAnalyticsBytes / numberOfBytes, 100) AS percentAnalyticsBytesQuantiles,
  APPROX_QUANTILES(numberOfSocialBytes / numberOfBytes, 100) AS percentSocialBytesQuantiles,
  APPROX_QUANTILES(numberOfVideoBytes / numberOfBytes, 100) AS percentVideoBytesQuantiles,
  APPROX_QUANTILES(numberOfUtilityBytes / numberOfBytes, 100) AS percentUtilityBytesQuantiles,
  APPROX_QUANTILES(numberOfHostingBytes / numberOfBytes, 100) AS percentHostingBytesQuantiles,
  APPROX_QUANTILES(numberOfMarketingBytes / numberOfBytes, 100) AS percentMarketingBytesQuantiles,
  APPROX_QUANTILES(numberOfCustomerSuccessBytes / numberOfBytes, 100) AS percentCustomerSuccessBytesQuantiles,
  APPROX_QUANTILES(numberOfContentBytes / numberOfBytes, 100) AS percentContentBytesQuantiles,
  APPROX_QUANTILES(numberOfCdnBytes / numberOfBytes, 100) AS percentCdnBytesQuantiles,
  APPROX_QUANTILES(numberOfTagManagerBytes / numberOfBytes, 100) AS percentTagManagerBytesQuantiles,
  APPROX_QUANTILES(numberOfOtherBytes / numberOfBytes, 100) AS percentOtherBytesQuantiles
FROM (
  SELECT
    client,
    pageUrl,
    COUNT(0) AS numberOfRequests,
    SUM(requestBytes) AS numberOfBytes,
    SUM(IF(thirdPartyDomain IS NULL, requestBytes, 0)) AS numberOfFirstPartyBytes,
    SUM(IF(thirdPartyDomain IS NOT NULL, requestBytes, 0)) AS numberOfThirdPartyBytes,
    SUM(IF(thirdPartyCategory = 'ad', requestBytes, 0)) AS numberOfAdBytes,
    SUM(IF(thirdPartyCategory = 'analytics', requestBytes, 0)) AS numberOfAnalyticsBytes,
    SUM(IF(thirdPartyCategory = 'social', requestBytes, 0)) AS numberOfSocialBytes,
    SUM(IF(thirdPartyCategory = 'video', requestBytes, 0)) AS numberOfVideoBytes,
    SUM(IF(thirdPartyCategory = 'utility', requestBytes, 0)) AS numberOfUtilityBytes,
    SUM(IF(thirdPartyCategory = 'hosting', requestBytes, 0)) AS numberOfHostingBytes,
    SUM(IF(thirdPartyCategory = 'marketing', requestBytes, 0)) AS numberOfMarketingBytes,
    SUM(IF(thirdPartyCategory = 'customer-success', requestBytes, 0)) AS numberOfCustomerSuccessBytes,
    SUM(IF(thirdPartyCategory = 'content', requestBytes, 0)) AS numberOfContentBytes,
    SUM(IF(thirdPartyCategory = 'cdn', requestBytes, 0)) AS numberOfCdnBytes,
    SUM(IF(thirdPartyCategory = 'tag-manager', requestBytes, 0)) AS numberOfTagManagerBytes,
    SUM(IF(thirdPartyCategory = 'other' OR thirdPartyCategory IS NULL, requestBytes, 0)) AS numberOfOtherBytes
  FROM (
    SELECT
      client,
      page AS pageUrl,
      respBodySize AS requestBytes,
      DomainsOver50Table.requestDomain AS thirdPartyDomain,
      ThirdPartyTable.category AS thirdPartyCategory
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
    WHERE
      date = '2019-07-01'
  )
  GROUP BY
    client,
    pageUrl
)
GROUP BY
  client
