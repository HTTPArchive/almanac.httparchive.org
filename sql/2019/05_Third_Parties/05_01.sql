#standardSQL
# Percentage of pages that include at least one third party resource.
SELECT
  COUNT(*) AS numberOfPages,
  COUNTIF(numberOfThirdPartyRequests > 0) AS numberOfPagesWithThirdParty,
  COUNTIF(numberOfThirdPartyRequests > 0) / COUNT(*) AS percentOfPagesWithThirdParty
FROM (
  SELECT
    pageUrl,
    COUNTIF(thirdPartyDomain IS NOT NULL) AS numberOfThirdPartyRequests
  FROM (
    SELECT
      page AS pageUrl,
      DomainsOver50Table.requestDomain AS thirdPartyDomain
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
  )
  GROUP BY
    pageUrl
)
