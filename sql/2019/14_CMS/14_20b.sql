#standardSQL
# 14_20b: Lighthouse A11y scores by CMS
SELECT
  app,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(report, "$.categories.accessibility.score") AS NUMERIC), 1000)[OFFSET(501)] AS median_a11y_score,
  COUNT(0) AS pages
FROM
  `httparchive.lighthouse.2019_07_01_mobile`
LEFT JOIN
  `httparchive.technologies.2019_07_01_mobile`
USING (url)
WHERE
  category = 'CMS'
GROUP BY
  app
ORDER BY
  pages DESC
