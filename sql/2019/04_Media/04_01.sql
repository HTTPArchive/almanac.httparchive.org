#standardSQL
# 04_01-02: Lighthouse media scores, savings, and item lengths
CREATE TEMPORARY FUNCTION getAuditResults(report STRING)
RETURNS ARRAY<STRUCT<name STRING, score NUMERIC, ms NUMERIC, bytes NUMERIC, items NUMERIC>> LANGUAGE js AS '''
try {
  var $ = JSON.parse(report);
  var audits = ['offscreen-images', 'uses-optimized-images', 'uses-responsive-images', 'uses-webp-images', 'efficient-animated-content']
  return audits.map(audit => ({
    name: audit,
    score: $.audits[audit].score,
    ms: $.audits[audit].details.overallSavingsMs,
    bytes: $.audits[audit].details.overallSavingsBytes,
    items: $.audits[audit].details.items.length
  }));
} catch (e) {
  return null;
}
''';

SELECT
  percentile,
  audit.name,
  APPROX_QUANTILES(audit.score, 1000)[OFFSET(percentile * 10)] AS score,
  APPROX_QUANTILES(audit.ms, 1000)[OFFSET(percentile * 10)] AS ms,
  ROUND(APPROX_QUANTILES(audit.bytes, 1000)[OFFSET(percentile * 10)] / 1024, 2) AS kbytes,
  APPROX_QUANTILES(audit.items, 1000)[OFFSET(percentile * 10)] AS items
FROM
  `httparchive.lighthouse.2019_07_01_mobile`,
  UNNEST(getAuditResults(report)) AS audit,
  UNNEST([5,10,15,20, 25,30,35,40,45, 50,55,60,65,70, 75,80,85, 90,95]) AS percentile
GROUP BY
  percentile,
  name
ORDER BY
  percentile,
  name
