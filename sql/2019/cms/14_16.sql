#standardSQL
# 14_16: Top analytics providers
SELECT
  client,
  canonicalDomain AS provider,
  COUNT(DISTINCT page) AS freq_pages,
  COUNT(0) AS freq_requests,
  total AS total_pages,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_requests,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct_requests
FROM
  `httparchive.almanac.summary_requests` r
JOIN (
  SELECT _TABLE_SUFFIX AS client, url AS page
  FROM `httparchive.technologies.2019_07_01_*`
  WHERE category = 'CMS')
USING
  (client, page)
JOIN
  `httparchive.almanac.third_parties` tp
ON
  NET.HOST(url) = domain
JOIN (
  SELECT _TABLE_SUFFIX AS client, COUNT(0) AS total
  FROM `httparchive.summary_pages.2019_07_01_*`
  GROUP BY _TABLE_SUFFIX)
USING
  (client)
WHERE
  r.date = '2019-07-01' AND
  tp.date = '2019-07-01' AND
  category = 'analytics'
GROUP BY
  client,
  total,
  provider
ORDER BY
  freq_requests / total DESC
