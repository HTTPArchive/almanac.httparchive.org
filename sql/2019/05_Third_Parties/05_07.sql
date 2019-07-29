#standardSQL
# Top 100 third party domains by total byte weight
SELECT
  thirdPartyDomain,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes
FROM (
  SELECT
      SAFE_CAST(REGEXP_EXTRACT(payload, r'_bytesIn":(\d+)') AS INT64) AS requestBytes,
      NET.HOST(url) AS requestDomain,
      DomainsOver50Table.requestDomain as thirdPartyDomain
    FROM
      `httparchive.requests.2019_07_01_mobile`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
)
ORDER BY
  totalBytes DESC
GROUP BY
  thirdPartyDomain
LIMIT 100

