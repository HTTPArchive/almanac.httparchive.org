#standardSQL
# Top 100 third party domains by total script execution time.
CREATE TEMPORARY FUNCTION getExecutionTimes(report STRING)
RETURNS ARRAY<STRUCT<url STRING, execution_time FLOAT64>>
LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['bootup-time'].details.items.map(item => ({
    url: item.url,
    execution_time: item.scripting
  }));
} catch (e) {
  return [];
}
''';

SELECT
  thirdPartyDomain,
  COUNT(0) AS totalScripts,
  SUM(executionTime) AS totalExecutionTime,
  ROUND(SUM(executionTime) * 100 / MAX(t2.totalExecutionTime), 2) AS percentExecutionTime
FROM (
  SELECT
    item.execution_time AS executionTime,
    NET.HOST(item.url) AS requestDomain,
    DomainsOver50Table.requestDomain AS thirdPartyDomain
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`,
    UNNEST(getExecutionTimes(report)) AS item
  LEFT JOIN
    `lighthouse-infrastructure.third_party_web.2019_07_01_all_observed_domains` AS DomainsOver50Table
  ON
    NET.HOST(item.url) = DomainsOver50Table.requestDomain ) t1,
  (
  SELECT
    SUM(item.execution_time) AS totalExecutionTime
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`,
    UNNEST(getExecutionTimes(report)) AS item ) t2
WHERE
  thirdPartyDomain IS NOT NULL
GROUP BY
  thirdPartyDomain
ORDER BY
  totalExecutionTime DESC
LIMIT
  100
