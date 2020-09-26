#standardSQL
# Get summary of all lighthouse scores for a category
# Note scores, weightings, groups and descriptions may be off in mixed months when new versions of Lighthouse roles out

CREATE TEMPORARY FUNCTION getAudits(report STRING, category STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, description STRING, score INT64>> LANGUAGE js AS '''
var $ = JSON.parse(report);
var auditrefs = $.categories[category].auditRefs;
var audits = $.audits;
var results = [];
for (auditref of auditrefs) {
  results.push({
    id: auditref.id,
    weight: auditref.weight,
    audit_group: auditref.group,
    title: audits[auditref.id].title,
    description: audits[auditref.id].description,
    score: audits[auditref.id].score
  });
}
return results;
''';

SELECT
  audits.id,
  countif(audits.score > 0) AS num_pages,
  count(0) AS total,
  countif(audits.score > 0) / count(0) as pct,
  MAX(audits.weight) as weight,
  MAX(audits.audit_group) as audit_group,
  MAX(audits.description) as description
FROM `httparchive.lighthouse.2020_08_01_mobile`,
  UNNEST(getAudits(report, "pwa")) AS audits
GROUP BY
  audits.id
ORDER BY
  weight desc
