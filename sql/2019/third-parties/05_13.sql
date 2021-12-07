#standardSQL
# Percentile breakdown page-relative percentage of total script execution time that is from third party requests broken down by third party category.
CREATE TEMPORARY FUNCTION getExecutionTimes(report STRING)
RETURNS ARRAY<STRUCT<url STRING, execution_time FLOAT64>>
LANGUAGE js
AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['bootup-time'].details.items.map(item => ({
    url: item.url,
    execution_time: item.scripting
  }));
} catch (e) {
  return [];
}
''';

SELECT
  COUNT(0) AS numberOfPages,
  APPROX_QUANTILES(amountOfThirdPartyTime / executionTime, 100) AS percentThirdPartyTimeQuantiles,
  APPROX_QUANTILES(amountOfAdTime / executionTime, 100) AS percentAdTimeQuantiles,
  APPROX_QUANTILES(amountOfAnalyticsTime / executionTime, 100) AS percentAnalyticsTimeQuantiles,
  APPROX_QUANTILES(amountOfSocialTime / executionTime, 100) AS percentSocialTimeQuantiles,
  APPROX_QUANTILES(amountOfVideoTime / executionTime, 100) AS percentVideoTimeQuantiles,
  APPROX_QUANTILES(amountOfUtilityTime / executionTime, 100) AS percentUtilityTimeQuantiles,
  APPROX_QUANTILES(amountOfHostingTime / executionTime, 100) AS percentHostingTimeQuantiles,
  APPROX_QUANTILES(amountOfMarketingTime / executionTime, 100) AS percentMarketingTimeQuantiles,
  APPROX_QUANTILES(amountOfCustomerSuccessTime / executionTime, 100) AS percentCustomerSuccessTimeQuantiles,
  APPROX_QUANTILES(amountOfContentTime / executionTime, 100) AS percentContentTimeQuantiles,
  APPROX_QUANTILES(amountOfCdnTime / executionTime, 100) AS percentCdnTimeQuantiles,
  APPROX_QUANTILES(amountOfTagManagerTime / executionTime, 100) AS percentTagManagerTimeQuantiles,
  APPROX_QUANTILES(amountOfOtherTime / executionTime, 100) AS percentOtherTimeQuantiles
FROM (
  SELECT
    pageUrl,
    COUNT(0) AS numberOfScripts,
    SUM(executionTime) AS executionTime,
    SUM(IF(thirdPartyDomain IS NULL, executionTime, 0)) AS amountOfFirstPartyTime,
    SUM(IF(thirdPartyDomain IS NOT NULL, executionTime, 0)) AS amountOfThirdPartyTime,
    SUM(IF(thirdPartyCategory = 'ad', executionTime, 0)) AS amountOfAdTime,
    SUM(IF(thirdPartyCategory = 'analytics', executionTime, 0)) AS amountOfAnalyticsTime,
    SUM(IF(thirdPartyCategory = 'social', executionTime, 0)) AS amountOfSocialTime,
    SUM(IF(thirdPartyCategory = 'video', executionTime, 0)) AS amountOfVideoTime,
    SUM(IF(thirdPartyCategory = 'utility', executionTime, 0)) AS amountOfUtilityTime,
    SUM(IF(thirdPartyCategory = 'hosting', executionTime, 0)) AS amountOfHostingTime,
    SUM(IF(thirdPartyCategory = 'marketing', executionTime, 0)) AS amountOfMarketingTime,
    SUM(IF(thirdPartyCategory = 'customer-success', executionTime, 0)) AS amountOfCustomerSuccessTime,
    SUM(IF(thirdPartyCategory = 'content', executionTime, 0)) AS amountOfContentTime,
    SUM(IF(thirdPartyCategory = 'cdn', executionTime, 0)) AS amountOfCdnTime,
    SUM(IF(thirdPartyCategory = 'tag-manager', executionTime, 0)) AS amountOfTagManagerTime,
    SUM(IF(thirdPartyCategory = 'other' OR thirdPartyCategory IS NULL, executionTime, 0)) AS amountOfOtherTime
  FROM (
    SELECT
      lh.url AS pageUrl,
      item.execution_time AS executionTime,
      DomainsOver50Table.requestDomain AS thirdPartyDomain,
      ThirdPartyTable.category AS thirdPartyCategory
    FROM
      `httparchive.lighthouse.2019_07_01_mobile` AS lh,
      UNNEST(getExecutionTimes(lh.report)) AS item
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(item.url) = ThirdPartyTable.domain
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(item.url) = DomainsOver50Table.requestDomain
  )
  GROUP BY
    pageUrl
)
