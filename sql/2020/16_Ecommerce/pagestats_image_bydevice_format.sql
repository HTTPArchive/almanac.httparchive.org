#standardSQL
# 13_06: Distribution of image stats
SELECT
  client,
  format,
  COUNT(DISTINCT url) AS freq,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(DISTINCT url) * 100 / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.summary_requests`
JOIN
  (SELECT DISTINCT _TABLE_SUFFIX AS client, url AS page FROM `httparchive.technologies.2020_08_01_*` WHERE category = 'Ecommerce')
USING (client, page)
WHERE
  type = 'image'
GROUP BY
  client,
  format
ORDER BY
  freq / total DESC
