#standardSQL
# 01_10: Top JS frameworks
SELECT
  app,
  _TABLE_SUFFIX AS client,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX)
WHERE
  category = 'JavaScript Frameworks'
GROUP BY
  app,
  client,
  total
ORDER BY
  freq DESC
