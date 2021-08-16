#standardSQL
# Top 100 third party requests by total script execution time.
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
  requestUrl,
  COUNT(0) AS totalScripts,
  SUM(executionTime) AS totalExecutionTime,
  ROUND(SUM(executionTime) * 100 / MAX(t2.totalExecutionTime), 2) AS percentExecutionTime
FROM (
  SELECT
    item.url AS requestUrl,
    item.execution_time AS executionTime
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`,
    UNNEST(getExecutionTimes(report)) AS item) t1,
  (
    SELECT
      SUM(item.execution_time) AS totalExecutionTime
    FROM
      `httparchive.lighthouse.2019_07_01_mobile`,
      UNNEST(getExecutionTimes(report)) AS item ) t2
WHERE requestUrl != 'Other'
GROUP BY
  requestUrl
ORDER BY
  totalExecutionTime DESC
LIMIT 100
