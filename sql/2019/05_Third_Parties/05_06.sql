#standardSQL
# Top 100 third party domains by request volume
SELECT
  thirdPartyDomain,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes
FROM (
  SELECT
      respSize AS requestBytes,
      NET.HOST(url) AS requestDomain,
      DomainsOver50Table.requestDomain AS thirdPartyDomain
    FROM
      `httparchive.summary_requests.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
)
GROUP BY
  thirdPartyDomain
ORDER BY
  totalRequests DESC
LIMIT 100

