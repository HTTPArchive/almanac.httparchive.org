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
  _TABLE_SUFFIX AS client,
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
  `httparchive.lighthouse.2022_06_01_*`,
  UNNEST(getAudits(JSON_EXTRACT(report, '$.categories.pwa.auditRefs'), JSON_EXTRACT(report, '$.audits'))) AS audits
JOIN (
  SELECT
    _TABLE_SUFFIX,
    url
  FROM
    `httparchive.pages.2022_06_01_*`
  WHERE
    JSON_EXTRACT(payload, '$._pwa.serviceWorkerHeuristic') = 'true' AND
    JSON_EXTRACT(payload, '$._pwa.manifests') != '[]' AND JSON_EXTRACT(payload, '$._pwa.manifests') != '{}'
)
USING (_TABLE_SUFFIX, url)
GROUP BY
  client,
  audits.id
UNION ALL
SELECT
  _TABLE_SUFFIX AS client,
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
  `httparchive.lighthouse.2022_06_01_*`,
  UNNEST(getAudits(JSON_EXTRACT(report, '$.categories.pwa.auditRefs'), JSON_EXTRACT(report, '$.audits'))) AS audits
GROUP BY
  client,
  audits.id
ORDER BY
  client,
  type DESC,
  median_weight DESC,
  id
