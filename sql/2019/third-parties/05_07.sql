#standardSQL
# Top 100 third party domains by total byte weight
SELECT
  thirdPartyDomain,
  COUNT(0) AS totalRequests,
  SUM(requestBytes) AS totalBytes,
  ROUND(SUM(requestBytes) * 100 / MAX(totalRequestBytes), 2) AS percentBytes
FROM (
  SELECT
    respSize AS requestBytes,
    NET.HOST(url) AS requestDomain,
    DomainsOver50Table.requestDomain AS thirdPartyDomain
  FROM
    `httparchive.almanac.summary_requests`
  LEFT JOIN
    `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
  ON NET.HOST(url) = DomainsOver50Table.requestDomain
  WHERE
    date = '2019-07-01'
),
(
  SELECT SUM(respSize) AS totalRequestBytes FROM `httparchive.almanac.summary_requests` WHERE date = '2019-07-01'
)
WHERE thirdPartyDomain IS NOT NULL
GROUP BY
  thirdPartyDomain
ORDER BY
  totalBytes DESC
LIMIT 100
