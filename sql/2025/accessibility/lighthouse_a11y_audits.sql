#standardSQL
# Get summary of all Lighthouse scores for a category
CREATE TEMPORARY FUNCTION getAudits(report JSON, category STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, description STRING, score INT64>> LANGUAGE js AS '''
try {
  var auditrefs = report.categories[category].auditRefs;
  var audits = report.audits;
  var results = [];
  for (auditref of auditrefs) {
    results.push({
      id: auditref.id,
      weight: auditref.weight,
      audit_group: auditref.group,
      description: audits[auditref.id].description,
      score: audits[auditref.id].score
    });
  }
  return results;
} catch (e) {
  return [{}];
}
''';
SELECT
  client,
  is_root_page,
  audits.id AS id,
  COUNTIF(audits.score > 0) AS num_pages,
  COUNT(0) AS total,
  COUNTIF(audits.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(audits.score > 0), COUNTIF(audits.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(audits.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(audits.audit_group) AS audit_group,
  MAX(audits.description) AS description
FROM
  `httparchive.crawl.pages`,
  UNNEST(getAudits(lighthouse, 'accessibility')) AS audits
WHERE
  date = '2025-07-01' AND
  lighthouse IS NOT NULL AND
  lighthouse.categories IS NOT NULL
GROUP BY
  client,
  is_root_page,
  audits.id,
  date
ORDER BY
  client,
  is_root_page,
  median_weight DESC,
  audits.id;
