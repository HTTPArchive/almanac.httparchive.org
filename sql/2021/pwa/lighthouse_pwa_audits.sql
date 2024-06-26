#standardSQL
# Get summary of all lighthouse PWA audits, for both PWA pages and all pages
# Note scores, weightings, groups and descriptions may be off in mixed months when new versions of Lighthouse roles out

CREATE TEMPORARY FUNCTION getAudits(auditRefs STRING, audits STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, description STRING, score INT64>> LANGUAGE js AS '''
var auditrefs = JSON.parse(auditRefs);
var audits = JSON.parse(audits);
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
''';

SELECT
  'PWA Sites' AS type,
  audits.id AS id,
  COUNTIF(audits.score > 0) AS num_pages,
  COUNT(0) AS total,
  COUNTIF(audits.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(audits.score > 0), COUNTIF(audits.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(audits.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(audits.audit_group) AS audit_group,
  MAX(audits.description) AS description
FROM
  `httparchive.lighthouse.2021_07_01_mobile`,
  UNNEST(getAudits(JSON_EXTRACT(report, '$.categories.pwa.auditRefs'), JSON_EXTRACT(report, '$.audits'))) AS audits
JOIN (
  SELECT
    url
  FROM
    `httparchive.pages.2021_07_01_mobile`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true' AND
    JSON_EXTRACT(payload, '$._pwa.manifests') != '[]'
)
USING (url)
GROUP BY
  audits.id
UNION ALL
SELECT
  'ALL Sites' AS type,
  audits.id AS id,
  COUNTIF(audits.score > 0) AS num_pages,
  COUNT(0) AS total,
  COUNTIF(audits.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(audits.score > 0), COUNTIF(audits.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(audits.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(audits.audit_group) AS audit_group,
  MAX(audits.description) AS description
FROM
  `httparchive.lighthouse.2021_07_01_mobile`,
  UNNEST(getAudits(JSON_EXTRACT(report, '$.categories.pwa.auditRefs'), JSON_EXTRACT(report, '$.audits'))) AS audits
GROUP BY
  audits.id
ORDER BY
  type DESC,
  median_weight DESC,
  id
