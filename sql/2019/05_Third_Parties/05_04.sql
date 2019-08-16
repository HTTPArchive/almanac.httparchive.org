#standardSQL
# Percentage of total bytes that are from third party requests broken down by third party category by resource type.
SELECT
  client,
  thirdPartyCategory,
  contentType,
  SUM(requestBytes) AS totalBytes,
  ROUND(SUM(requestBytes) * 100 / SUM(SUM(requestBytes)) OVER (), 4) AS percentBytes
FROM (
  SELECT
      client,
      type AS contentType,
      respBodySize AS requestBytes,
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
ORDER BY percentBytes DESC
