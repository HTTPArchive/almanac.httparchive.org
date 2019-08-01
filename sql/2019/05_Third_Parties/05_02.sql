#standardSQL
# Percentage of pages that include at least one ad resource.
SELECT
  COUNT(*) as numberOfPages,
  COUNTIF(numberOfAdRequests > 0) AS numberOfPagesWithAd,
  COUNT(*) / COUNTIF(numberOfAdRequests > 0) AS percentOfPagesWithAd
FROM (
  SELECT
    pageUrl,
    COUNTIF(thirdPartyCategory = 'ad') AS numberOfAdRequests
  FROM (
    SELECT
      page AS pageUrl,
      ThirdPartyTable.category as thirdPartyCategory
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
  )
  GROUP BY
    pageUrl
)
