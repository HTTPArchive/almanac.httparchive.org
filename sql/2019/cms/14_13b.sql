#standardSQL
# 14_13b: Popular image formats
SELECT
  client,
  format,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`
JOIN (SELECT _TABLE_SUFFIX AS client, url AS page FROM `httparchive.technologies.2019_07_01_*` WHERE category = 'CMS')
USING (client, page)
WHERE
  date = '2019-07-01' AND
  type = 'image'
GROUP BY
  client,
  format
ORDER BY
  freq / total DESC
