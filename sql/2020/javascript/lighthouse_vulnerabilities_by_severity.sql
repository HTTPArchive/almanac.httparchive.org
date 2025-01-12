#standardSQL
# Vulnerabilities per page by severity
CREATE TEMPORARY FUNCTION getVulnerabilities(audit STRING)
RETURNS ARRAY<STRUCT<severity STRING, freq INT64>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details.items.map(({highestSeverity, vulnCount}) => {
    return {
      severity: highestSeverity,
      freq: vulnCount
    };
  });
} catch(e) {
  return [];
}
''';

SELECT
  severity,
  COUNT(DISTINCT page) AS pages,
  APPROX_QUANTILES(freq, 1000)[OFFSET(500)] AS median_vulnerability_count_per_page
FROM (
  SELECT
    url AS page,
    vulnerability.severity,
    SUM(vulnerability.freq) AS freq
  FROM
    `httparchive.lighthouse.2020_08_01_mobile`
  LEFT JOIN
    UNNEST(getVulnerabilities(JSON_EXTRACT(report, "$.audits['no-vulnerable-libraries']"))) AS vulnerability
  GROUP BY
    page,
    severity
)
GROUP BY
  severity
ORDER BY
  pages DESC
