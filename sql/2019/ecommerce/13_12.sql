#standardSQL
# 13_12: Lighthouse indexability scores
SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits.is-crawlable.score") AS crawlable,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY 0) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_mobile`,
  (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_mobile`)
JOIN
  `httparchive.lighthouse.2019_07_01_mobile`
USING (url)
WHERE
  category = 'Ecommerce'
GROUP BY
  crawlable
ORDER BY
  freq / total DESC
