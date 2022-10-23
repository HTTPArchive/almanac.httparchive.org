SELECT
  COUNTIF(JSON_VALUE(report, '$.audits.viewport.score') = '0') AS viewport_failed,
  COUNT(0) AS total,
  COUNTIF(JSON_VALUE(report, '$.audits.viewport.score') = '0') / COUNT(0) AS pct_failed
FROM
  `httparchive.lighthouse.2022_06_01_mobile`
