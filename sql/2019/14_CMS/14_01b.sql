#standardSQL
# 14_01b: % CMS (any)
SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS freq,
  total,
  ROUND(COUNT(0) * 100 / total, 2) AS pct
FROM
  `httparchive.technologies.2019_07_01_*`
JOIN
  (SELECT _TABLE_SUFFIX, COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_*` GROUP BY _TABLE_SUFFIX)
USING (_TABLE_SUFFIX)
WHERE
  category = 'CMS'
GROUP BY
  client,
  total
ORDER BY
  freq / total DESC