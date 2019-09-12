#standardSQL
# timeline view from the top-level HTTPArchive page 
#    https://httparchive.org/reports/state-of-the-web?start=2016_04_01&end=latest&view=list
# 13.6TB 


SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  UNIX_DATE(CAST(REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '-') AS DATE)) * 1000 * 60 * 60 * 24 AS timestamp,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  ROUND(SUM(IF(JSON_EXTRACT(report, '$.audits.no-vulnerable-libraries.score') IN ('false', '0'), 1, 0)) * 100 / COUNT(0), 2) AS percent
FROM
  `httparchive.lighthouse.*`
WHERE
  report IS NOT NULL AND
  JSON_EXTRACT(report, '$.audits.no-vulnerable-libraries.score') IS NOT NULL
GROUP BY
  date,
  timestamp,
  client
ORDER BY
  date DESC,
  client
