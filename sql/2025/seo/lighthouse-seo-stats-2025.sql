#standardSQL
# Lighthouse SEO Stats

CREATE TEMPORARY FUNCTION getAudits(audits JSON)
RETURNS ARRAY<STRUCT<
  id STRING,
  weight INT64,
  title STRING,
  description STRING,
  score FLOAT64
>> LANGUAGE js AS '''
var auditsObj = audits || {};
var results = [];
for (var auditId in auditsObj) {
  if (Object.prototype.hasOwnProperty.call(auditsObj, auditId)) {
    var audit = auditsObj[auditId] || {};
    results.push({
      id: auditId,
      weight: audit.weight || 0,
      title: audit.title || '',
      description: audit.description || '',
      score: (audit.score ?? null)
    });
  }
}
return results;
''';

WITH lighthouse_extraction AS (
  SELECT
    client,
    page,
    lighthouse AS report
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
)

SELECT
  client,
  audits.id AS id,
  COUNTIF(audits.score > 0) AS num_pages,
  COUNT(DISTINCT page) AS sites,
  COUNTIF(audits.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(audits.score > 0), COUNTIF(audits.score IS NOT NULL)) AS pct,
  APPROX_QUANTILES(audits.weight, 100)[OFFSET(50)] AS median_weight,
  MAX(audits.title) AS title,
  MAX(audits.description) AS description,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total   -- ✅ no is_root_page
FROM lighthouse_extraction,
UNNEST(getAudits(JSON_EXTRACT(report, '$.audits'))) AS audits
GROUP BY
  client,
  audits.id
ORDER BY
  client,
  median_weight DESC,
  id;
