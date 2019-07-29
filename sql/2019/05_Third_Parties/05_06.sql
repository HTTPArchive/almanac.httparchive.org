#standardSQL
# Top 100 third party domains by request volume
SELECT
  thirdPartyDomain,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes
FROM (
  SELECT
      page AS pageUrl,
      NET.HOST(page) AS pageDomain,
      url AS requestUrl,
      REGEXP_EXTRACT(payload, r'(?i)content-type:\s*([a-z0-9_\/-]+)') AS contentType,
      SAFE_CAST(REGEXP_EXTRACT(payload, r'_bytesIn":(\d+)') AS INT64) AS requestBytes,
      NET.HOST(url) AS requestDomain,
      DomainsOver50Table.requestDomain as thirdPartyDomain,
      ThirdPartyTable.category as thirdPartyCategory
    FROM
      `httparchive.requests.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01` AS ThirdPartyTable
    ON NET.HOST(url) = ThirdPartyTable.domain
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
)
ORDER BY
  totalRequests DESC
GROUP BY
  thirdPartyDomain
LIMIT 100

