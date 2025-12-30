#standardSQL
-- Lighthouse SEO Stats

CREATE TEMPORARY FUNCTION getAudits(audits JSON)
RETURNS ARRAY<STRUCT<
  id STRING,
  title STRING,
  description STRING,
  score FLOAT64
>>
LANGUAGE js AS r'''
var auditsObj = audits || {};
var results = [];
for (var auditId in auditsObj) {
  if (Object.prototype.hasOwnProperty.call(auditsObj, auditId)) {
    var a = auditsObj[auditId] || {};
    results.push({
      id: auditId,
      title: a.title || '',
      description: a.description || '',
      score: (a.score ?? null)
    });
  }
}
return results;
''';

WITH lighthouse_extraction AS (
  SELECT
    client,
    page,
    lighthouse AS report,
    CASE
      WHEN is_root_page = FALSE THEN 'Secondarypage'
      WHEN is_root_page = TRUE THEN 'Homepage'
      ELSE 'No Assigned Page'
    END AS is_root_page
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  audits.id AS id,
  COUNTIF(audits.score > 0) AS num_pages,
  COUNT(DISTINCT page) AS sites,
  COUNTIF(audits.score IS NOT NULL) AS total_applicable,
  SAFE_DIVIDE(COUNTIF(audits.score > 0), COUNTIF(audits.score IS NOT NULL)) AS pct,
  MAX(audits.title) AS title,
  MAX(audits.description) AS description,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total
FROM
  lighthouse_extraction,
  UNNEST(getAudits(JSON_EXTRACT(report, '$.audits'))) AS audits
GROUP BY
  client,
  is_root_page,
  audits.id
ORDER BY
  client,
  is_root_page,
  id;
