#standardSQL
# 08_40: Check for 'Vulnerable JS' noted in Lighthouse run
#
#  Lighthouse score = 0 - means site contains at min 1 vulnerable JS
SELECT
  JSON_EXTRACT_SCALAR(report, '$.audits.no-vulnerable-libraries.score') AS score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS pct
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
GROUP BY
  score
ORDER BY
  freq DESC
