#standardSQL

-- counts font-display value usage

SELECT
  ROUND(SUM(IF(JSON_EXTRACT(report, '$.audits.font-display.score') IN ('true', '1'), 1, 0)) * 100 / COUNT(0), 2) AS percent
FROM
  `httparchive.lighthouse.2019_07_01_*`
WHERE
  report IS NOT NULL AND
  JSON_EXTRACT(report, '$.audits.font-display.score') IS NOT NULL
