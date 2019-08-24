#standardSQL
#
# timeline view from the top-level HTTPArchive page 
#    https://httparchive.org/reports/progressive-web-apps?start=2017_08_01&end=latest&view=list#swControlledPages
# 13.6TB 


SELECT
  SUBSTR(_TABLE_SUFFIX, 0, 10) AS date,
  UNIX_DATE(CAST(REPLACE(SUBSTR(_TABLE_SUFFIX, 0, 10), '_', '-') AS DATE)) * 1000 * 60 * 60 * 24 AS timestamp,
  IF(ENDS_WITH(_TABLE_SUFFIX, 'desktop'), 'desktop', 'mobile') AS client,
  ROUND(SUM(IF(JSON_EXTRACT(payload, '$._blinkFeatureFirstUsed.Features.ServiceWorkerControlledPage') IS NOT NULL, 1, 0)) * 100 / COUNT(0), 2) AS percent
FROM
  `httparchive.pages.*`
GROUP BY
  date,
  timestamp,
  client
ORDER BY
  date DESC,
  client
