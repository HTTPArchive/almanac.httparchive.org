#standardSQL
# Top 100 third party domains by request volume
SELECT
  thirdPartyDomain,
  COUNT(0) AS totalRequests,
  ROUND(COUNT(0) * 100 / MAX(totalRequestCount), 4) AS percentRequests,
  SUM(requestBytes) AS totalBytes
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
  SELECT COUNT(0) AS totalRequestCount FROM `httparchive.almanac.summary_requests` WHERE date = '2019-07-01'
)
GROUP BY
  thirdPartyDomain
ORDER BY
  totalRequests DESC
LIMIT 100
