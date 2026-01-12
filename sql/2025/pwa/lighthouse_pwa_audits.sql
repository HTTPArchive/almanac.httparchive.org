#standardSQL
# Get summary of all Lighthouse PWA audits, for both PWA pages and all pages

CREATE TEMPORARY FUNCTION getAudits(auditRefs STRING, audits STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, description STRING, score FLOAT64>> LANGUAGE js AS '''
try {
  const auditrefs = JSON.parse(auditRefs) || [];
  const auditsObj = JSON.parse(audits) || {};
  const results = [];
  for (const auditref of auditrefs) {
    const a = auditsObj[auditref.id] || {};
    results.push({
      id: auditref.id,
      weight: auditref.weight || 0,
      audit_group: auditref.group || null,
      title: a.title || null,
      description: a.description || null,
      score: a.score == null ? null : Number(a.score)
    });
  }
  return results;
} catch (e) {
  return [];
}
''';

-- PWA Sites
SELECT
  p.client AS client,
  'PWA Sites' AS type,
  a.id AS id,
  COUNTIF(a.score > 0) AS num_pages,
  COUNT(0) AS total,
  COUNTIF(a.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(a.score > 0), COUNTIF(a.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(a.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(a.audit_group) AS audit_group,
  MAX(a.description) AS description
FROM `httparchive.crawl.pages` p,
  UNNEST(
    getAudits(
      TO_JSON_STRING(JSON_QUERY(p.lighthouse, '$.categories.pwa.auditRefs')),
      TO_JSON_STRING(JSON_QUERY(p.lighthouse, '$.audits'))
    )
  ) AS a
WHERE p.date = DATE '2024-01-01' AND p.is_root_page AND
  JSON_VALUE(p.custom_metrics.other, '$.pwa.serviceWorkerHeuristic') = 'true' AND
  TO_JSON_STRING(JSON_QUERY(p.custom_metrics.other, '$.pwa.manifests')) NOT IN ('[]', '{}', 'null')
GROUP BY client, a.id

UNION ALL

-- ALL Sites
SELECT
  p.client AS client,
  'ALL Sites' AS type,
  a.id AS id,
  COUNTIF(a.score > 0) AS num_pages,
  COUNT(0) AS total,
  COUNTIF(a.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(a.score > 0), COUNTIF(a.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(a.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(a.audit_group) AS audit_group,
  MAX(a.description) AS description
FROM `httparchive.crawl.pages` p,
  UNNEST(
    getAudits(
      TO_JSON_STRING(JSON_QUERY(p.lighthouse, '$.categories.pwa.auditRefs')),
      TO_JSON_STRING(JSON_QUERY(p.lighthouse, '$.audits'))
    )
  ) AS a
WHERE p.date = DATE '2024-01-01' AND p.is_root_page
GROUP BY client, a.id
ORDER BY client, type DESC, median_weight DESC, id;
