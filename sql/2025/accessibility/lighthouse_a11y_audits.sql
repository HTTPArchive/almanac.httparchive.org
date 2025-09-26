– standardSQL
– Web Almanac — Lighthouse Accessibility audits summary (2025 schema)
– Google Sheets: lighthouse_a11y_audits

– How this differs from the 2024 script:
– • Lighthouse is JSON-typed in 2025 → JS UDFs require STRING, so we wrap with
–   TO_JSON_STRING(lighthouse) both in the UDF call and the “empty” check.
– • Table/partition: use httparchive.crawl.pages with date = DATE ‘2025-07-01’
–   (2024 used httparchive.all.pages and a string date).
– • Types: weight/score are FLOAT64 (LHR scores/weights are 0–1 floats), not INT64.
– • Removed unused GROUP BY date (date isn’t selected).
– • Structure preserved: UDF flattens auditRefs; CROSS JOIN UNNEST; per-{client,is_root_page}
–   aggregation of pass/fail counts, applicable totals, percentage, median weight, and metadata.
CREATE TEMPORARY FUNCTION getAudits(report STRING, category STRING)
RETURNS ARRAY<
  STRUCT<
    id STRING,
    weight FLOAT64,
    audit_group STRING,
    title STRING,
    description STRING,
    score FLOAT64
  >
> LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  var auditrefs = $.categories && $.categories[category] ? $.categories[category].auditRefs : [];
  var audits = $.audits || {};
  var results = [];
  for (var i = 0; i < auditrefs.length; i++) {
    var auditref = auditrefs[i];
    var a = audits[auditref.id] || {};
    results.push({
      id: auditref.id,
      weight: (typeof auditref.weight === 'number') ? auditref.weight : 0,
      audit_group: auditref.group || null,
      title: a.title || null,
      description: a.description || null,
      score: (typeof a.score === 'number') ? a.score : null
    });
  }
  return results;
} catch (e) {
  return [];
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
  -- `httparchive.sample_data.pages_10k`,
  UNNEST(getAudits(TO_JSON_STRING(lighthouse), 'accessibility')) AS audits
WHERE
  date = DATE '2025-07-01' AND -- Comment out if using `httparchive.sample_data.pages_10k`,
  lighthouse IS NOT NULL AND
  TO_JSON_STRING(lighthouse) != '{}'
GROUP BY
  client,
  is_root_page,
  audits.id
ORDER BY
  client,
  is_root_page,
  median_weight DESC,
  audits.id;
