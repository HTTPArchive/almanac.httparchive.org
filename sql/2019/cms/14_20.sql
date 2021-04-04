#standardSQL
# 14_20: Lighthouse A11y scores
SELECT
  JSON_EXTRACT_SCALAR(report, "$.categories.accessibility.score") AS a11y_score,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER () AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (), 2) AS pct
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
LEFT JOIN
  `httparchive.technologies.2019_07_01_mobile`
USING (url)
WHERE
  category = 'CMS'
GROUP BY
  a11y_score
HAVING
  a11y_score IS NOT NULL
ORDER BY
  freq / total DESC
