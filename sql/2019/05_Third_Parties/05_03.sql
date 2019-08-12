#standardSQL
# Percentage of requests that are third party requests broken down by third party category by resource type.
SELECT
  client,
  thirdPartyCategory,
  contentType,
  COUNT(0) AS totalRequests,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 4) AS percentRequests
FROM (
  SELECT
      client,
      type AS contentType,
      ThirdPartyTable.category AS thirdPartyCategory
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
)
GROUP BY
  client,
  thirdPartyCategory,
  contentType
