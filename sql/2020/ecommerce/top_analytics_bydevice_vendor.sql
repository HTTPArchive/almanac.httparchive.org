#standardSQL
# 13_10: Top analytics providers
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
  `httparchive.almanac.summary_requests`
JOIN (
  SELECT _TABLE_SUFFIX AS client, url AS page
  FROM `httparchive.technologies.2020_08_01_*`
  WHERE category = 'Ecommerce'
)
USING (client, page)
JOIN
  `httparchive.almanac.third_parties`
ON
  NET.HOST(url) = domain
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total
  FROM `httparchive.summary_pages.2020_08_01_*`
  GROUP BY _TABLE_SUFFIX
)
USING (client)
WHERE
  `httparchive.almanac.summary_requests`.date = '2020-08-01' AND
  LOWER(category) = 'analytics'
GROUP BY
  client,
  total,
  provider
ORDER BY
  freq_requests / total DESC
