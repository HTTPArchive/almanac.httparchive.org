#standardSQL
# 01_08: Top JS libraries
SELECT
  app,
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT url) AS freq,
  total,
  ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pct
FROM (SELECT _TABLE_SUFFIX, COUNT(DISTINCT url) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
JOIN
  `httparchive.technologies.2019_07_01_*`
USING (_TABLE_SUFFIX)
WHERE
  category = 'JavaScript Libraries'
GROUP BY
  app,
  client,
  total
ORDER BY
  freq DESC
