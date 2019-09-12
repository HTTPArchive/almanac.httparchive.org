#standardSQL
# Percentage of pages that include at least one ad resource.
SELECT
  client,
  COUNT(0) AS numberOfPages,
  COUNTIF(numberOfAdRequests > 0) AS numberOfPagesWithAd,
  ROUND(COUNTIF(numberOfAdRequests > 0) * 100 / COUNT(0), 2) AS percentOfPagesWithAd
FROM (
  SELECT
    client,
    pageUrl,
    COUNTIF(thirdPartyCategory = 'ad') AS numberOfAdRequests
  FROM (
    SELECT
      client,
      page AS pageUrl,
      ThirdPartyTable.category AS thirdPartyCategory
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
  )
  GROUP BY
    client,
    pageUrl
)
GROUP BY
  client
