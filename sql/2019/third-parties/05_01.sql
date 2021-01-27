#standardSQL
# Percentage of pages that include at least one third party resource.
SELECT
  client,
  COUNT(0) AS numberOfPages,
  COUNTIF(numberOfThirdPartyRequests > 0) AS numberOfPagesWithThirdParty,
  ROUND(COUNTIF(numberOfThirdPartyRequests > 0) * 100 / COUNT(0), 2) AS percentOfPagesWithThirdParty
FROM (
  SELECT
    client,
    pageUrl,
    COUNTIF(thirdPartyDomain IS NOT NULL) AS numberOfThirdPartyRequests
  FROM (
    SELECT
      client,
      page AS pageUrl,
      DomainsOver50Table.requestDomain AS thirdPartyDomain
    FROM
      `httparchive.almanac.summary_requests`
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
