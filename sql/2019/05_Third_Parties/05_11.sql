#standardSQL
# Percentile breakdown page-relative percentage of requests that are third party requests broken down by third party category.
SELECT
  COUNT(*) as numberOfPages,
  COUNTIF(numberOfThirdPartyRequests > 0) AS numberOfPagesWithThirdParty,
  APPROX_QUANTILES(numberOfThirdPartyRequests / numberOfRequests, 100) AS percentThirdPartyRequestsQuantiles,
  APPROX_QUANTILES(numberOfAdRequests / numberOfRequests, 100) AS percentAdRequestsQuantiles,
  APPROX_QUANTILES(numberOfAnalyticsRequests / numberOfRequests, 100) as percentAnalyticsRequestsQuantiles,
  APPROX_QUANTILES(numberOfSocialRequests / numberOfRequests, 100) as percentSocialRequestsQuantiles,
  APPROX_QUANTILES(numberOfVideoRequests / numberOfRequests, 100) as percentVideoRequestsQuantiles,
  APPROX_QUANTILES(numberOfUtilityRequests / numberOfRequests, 100) as percentUtilityRequestsQuantiles,
  APPROX_QUANTILES(numberOfHostingRequests / numberOfRequests, 100) as percentHostingRequestsQuantiles,
  APPROX_QUANTILES(numberOfMarketingRequests / numberOfRequests, 100) as percentMarketingRequestsQuantiles,
  APPROX_QUANTILES(numberOfCustomerSuccessRequests / numberOfRequests, 100) as percentCustomerSuccessRequestsQuantiles,
  APPROX_QUANTILES(numberOfContentRequests / numberOfRequests, 100) as percentContentRequestsQuantiles,
  APPROX_QUANTILES(numberOfCdnRequests / numberOfRequests, 100) as percentCdnRequestsQuantiles,
  APPROX_QUANTILES(numberOfTagManagerRequests / numberOfRequests, 100) as percentTagManagerRequestsQuantiles,
  APPROX_QUANTILES(numberOfOtherRequests / numberOfRequests, 100) as percentOtherRequestsQuantiles
FROM (
  SELECT
    pageUrl,
    COUNT(*) as numberOfRequests,
    COUNTIF(thirdPartyDomain IS NULL) AS numberOfFirstPartyRequests,
    COUNTIF(thirdPartyDomain IS NOT NULL) AS numberOfThirdPartyRequests,
    COUNTIF(thirdPartyCategory = 'ad') AS numberOfAdRequests,
    COUNTIF(thirdPartyCategory = 'analytics') as numberOfAnalyticsRequests,
    COUNTIF(thirdPartyCategory = 'social') as numberOfSocialRequests,
    COUNTIF(thirdPartyCategory = 'video') as numberOfVideoRequests,
    COUNTIF(thirdPartyCategory = 'utility') as numberOfUtilityRequests,
    COUNTIF(thirdPartyCategory = 'hosting') as numberOfHostingRequests,
    COUNTIF(thirdPartyCategory = 'marketing') as numberOfMarketingRequests,
    COUNTIF(thirdPartyCategory = 'customer-success') as numberOfCustomerSuccessRequests,
    COUNTIF(thirdPartyCategory = 'content') as numberOfContentRequests,
    COUNTIF(thirdPartyCategory = 'cdn') as numberOfCdnRequests,
    COUNTIF(thirdPartyCategory = 'tag-manager') as numberOfTagManagerRequests,
    COUNTIF(thirdPartyCategory = 'other') as numberOfOtherRequests
  FROM (
    SELECT
      page AS pageUrl,
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
