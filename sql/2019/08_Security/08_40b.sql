#standardSQL
# 08_40b: Most frequent vulnerable libraries
CREATE TEMPORARY FUNCTION getVulnerabilities(report STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  return $.audits['no-vulnerable-libraries'].details.items.map(i => i.detectedLib.text.split('@')[0]);
} catch(e) {
  return [];
}
''';

SELECT
  lib,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.lighthouse.2019_07_01_mobile`,
  UNNEST(getVulnerabilities(report)) AS lib
GROUP BY
  lib
ORDER BY
  freq DESC
