#standardSQL
# Most frequent vulnerable libraries
CREATE TEMPORARY FUNCTION getVulnerabilities(audit STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(i => i.detectedLib.text.split('@')[0]);
} catch(e) {
  return [];
}
''';

SELECT
  lib,
  COUNT(0) AS freq,
  total,
  COUNT(0) / total AS pct
FROM
  `httparchive.lighthouse.2021_07_01_mobile`,
  UNNEST(getVulnerabilities(JSON_EXTRACT(report, "$.audits['no-vulnerable-libraries']"))) AS lib, (
  SELECT
    COUNT(DISTINCT url) AS total
  FROM
    `httparchive.lighthouse.2021_07_01_mobile`
)
GROUP BY
  lib,
  total
ORDER BY
  freq DESC
