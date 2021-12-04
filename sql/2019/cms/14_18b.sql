#standardSQL
# 14_18b: Lighthouse indexability scores by CMS
SELECT
  app,
  COUNTIF(crawlable = '1') AS passing,
  COUNT(0) AS total,
  ROUND(COUNTIF(crawlable = '1') * 100 / COUNT(0), 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_mobile`
JOIN (
  SELECT
    url,
    JSON_EXTRACT_SCALAR(report, '$.audits.is-crawlable.score') AS crawlable
  FROM
    `httparchive.lighthouse.2019_07_01_mobile`)
USING (url)
WHERE
  category = 'CMS' AND
  crawlable IS NOT NULL
GROUP BY
  app
ORDER BY
  total DESC
