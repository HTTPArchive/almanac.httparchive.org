#standardSQL
# Get summary of all lighthouse scores for a category
# Note scores, weightings, groups and descriptions may be off in mixed months when new versions of Lighthouse roles out

CREATE TEMPORARY FUNCTION getAudits(report STRING, category STRING)
RETURNS ARRAY<STRUCT<id STRING, weight INT64, audit_group STRING, title STRING, description STRING, score INT64>> LANGUAGE js AS '''
var $ = JSON.parse(report);
var auditrefs = $.categories[category].auditRefs;
var audits = $.audits;
$ = null;
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
  UNNEST(getAudits(report, 'accessibility')) AS audits
WHERE
  LENGTH(report) < 20000000  # necessary to avoid out of memory issues. Excludes very large results
GROUP BY
  client,
  audits.id
ORDER BY
  client,
  median_weight DESC,
  id
