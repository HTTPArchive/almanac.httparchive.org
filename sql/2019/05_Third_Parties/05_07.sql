#standardSQL
# Top 100 third party domains by total byte weight
SELECT
  thirdPartyDomain,
  COUNT(*) AS totalRequests,
  SUM(requestBytes) AS totalBytes,
  ROUND(SUM(requestBytes) * 100 / MAX(totalRequestBytes), 2) as percentBytes
FROM (
  SELECT
      respSize AS requestBytes,
      NET.HOST(url) AS requestDomain,
      DomainsOver50Table.requestDomain as thirdPartyDomain
    FROM
      `httparchive.almanac.summary_requests`
    LEFT JOIN
      `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
    ON NET.HOST(url) = DomainsOver50Table.requestDomain
) t1, (
  SELECT SUM(respSize) as totalRequestBytes FROM `httparchive.almanac.summary_requests`
) t2
WHERE thirdPartyDomain IS NOT NULL
GROUP BY
  thirdPartyDomain
ORDER BY
  totalBytes DESC
LIMIT 100

