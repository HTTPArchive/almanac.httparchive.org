#standardSQL
# Percentile breakdown page-relative percentage of requests that are third party requests broken down by third party category.
SELECT
  client,
  COUNT(0) AS numberOfPages,
  COUNTIF(numberOfThirdPartyRequests > 0) AS numberOfPagesWithThirdParty,
  APPROX_QUANTILES(numberOfThirdPartyRequests / numberOfRequests, 100) AS percentThirdPartyRequestsQuantiles,
  APPROX_QUANTILES(numberOfAdRequests / numberOfRequests, 100) AS percentAdRequestsQuantiles,
  APPROX_QUANTILES(numberOfAnalyticsRequests / numberOfRequests, 100) AS percentAnalyticsRequestsQuantiles,
  APPROX_QUANTILES(numberOfSocialRequests / numberOfRequests, 100) AS percentSocialRequestsQuantiles,
  APPROX_QUANTILES(numberOfVideoRequests / numberOfRequests, 100) AS percentVideoRequestsQuantiles,
  APPROX_QUANTILES(numberOfUtilityRequests / numberOfRequests, 100) AS percentUtilityRequestsQuantiles,
  APPROX_QUANTILES(numberOfHostingRequests / numberOfRequests, 100) AS percentHostingRequestsQuantiles,
  APPROX_QUANTILES(numberOfMarketingRequests / numberOfRequests, 100) AS percentMarketingRequestsQuantiles,
  APPROX_QUANTILES(numberOfCustomerSuccessRequests / numberOfRequests, 100) AS percentCustomerSuccessRequestsQuantiles,
  APPROX_QUANTILES(numberOfContentRequests / numberOfRequests, 100) AS percentContentRequestsQuantiles,
  APPROX_QUANTILES(numberOfCdnRequests / numberOfRequests, 100) AS percentCdnRequestsQuantiles,
  APPROX_QUANTILES(numberOfTagManagerRequests / numberOfRequests, 100) AS percentTagManagerRequestsQuantiles,
  APPROX_QUANTILES(numberOfOtherRequests / numberOfRequests, 100) AS percentOtherRequestsQuantiles
FROM (
  SELECT
    client,
    pageUrl,
    COUNT(0) AS numberOfRequests,
    COUNTIF(thirdPartyDomain IS NULL) AS numberOfFirstPartyRequests,
    COUNTIF(thirdPartyDomain IS NOT NULL) AS numberOfThirdPartyRequests,
    COUNTIF(thirdPartyCategory = 'ad') AS numberOfAdRequests,
    COUNTIF(thirdPartyCategory = 'analytics') AS numberOfAnalyticsRequests,
    COUNTIF(thirdPartyCategory = 'social') AS numberOfSocialRequests,
    COUNTIF(thirdPartyCategory = 'video') AS numberOfVideoRequests,
    COUNTIF(thirdPartyCategory = 'utility') AS numberOfUtilityRequests,
    COUNTIF(thirdPartyCategory = 'hosting') AS numberOfHostingRequests,
    COUNTIF(thirdPartyCategory = 'marketing') AS numberOfMarketingRequests,
    COUNTIF(thirdPartyCategory = 'customer-success') AS numberOfCustomerSuccessRequests,
    COUNTIF(thirdPartyCategory = 'content') AS numberOfContentRequests,
    COUNTIF(thirdPartyCategory = 'cdn') AS numberOfCdnRequests,
    COUNTIF(thirdPartyCategory = 'tag-manager') AS numberOfTagManagerRequests,
    COUNTIF(thirdPartyCategory = 'other' OR thirdPartyCategory IS NULL) AS numberOfOtherRequests
  FROM (
    SELECT
      client,
      page AS pageUrl,
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
