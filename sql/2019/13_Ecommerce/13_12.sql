#standardSQL
# 13_12: Lighthouse indexability scores
SELECT
  JSON_EXTRACT_SCALAR(report, "$.audits['is-crawlable']") AS crawlable,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_mobile`,
  (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_mobile`)
JOIN
  `httparchive.lighthouse.2019_07_01_mobile`
USING (url)
WHERE
  category = 'Ecommerce'
GROUP BY
  total,
  crawlable
ORDER BY
  freq / total DESC