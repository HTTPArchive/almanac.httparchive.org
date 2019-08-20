#standardSQL
# Percentage of script execution time that are from third party requests broken down by third party category.
CREATE TEMPORARY FUNCTION getExecutionTimes(report STRING)
RETURNS ARRAY<STRUCT<url STRING, execution_time FLOAT64>> LANGUAGE js AS '''
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
  category AS third_party_category,
  SUM(item.execution_time) AS total_execution_time,
  ROUND(SUM(item.execution_time) * 100 / SUM(SUM(item.execution_time)) OVER (), 4) AS pct_execution_time
FROM
  `httparchive.lighthouse.2019_07_01_mobile`,
  UNNEST(getExecutionTimes(report)) AS item
LEFT JOIN
  `lighthouse-infrastructure.third_party_web.2019_07_01`
ON
  NET.HOST(item.url) = domain
GROUP BY
  third_party_category
ORDER BY
  pct_execution_time DESC
