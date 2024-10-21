#standardSQL
SELECT
  LEFT(_TABLE_SUFFIX, 10) AS month,
  IF(ENDS_WITH(_TABLE_SUFFIX, '_desktop'), 'desktop', 'mobile') AS client,
  COUNT(DISTINCT IF(category = 'Cryptominers' OR category = 'Cryptominer', url, NULL)) AS freq,
  COUNT(DISTINCT url) AS total_pages,
  COUNT(DISTINCT IF(category = 'Cryptominers' OR category = 'Cryptominer', url, NULL)) / COUNT(DISTINCT url) AS pct
FROM
  `httparchive.technologies.*`
JOIN `httparchive.summary_pages.*` USING (_TABLE_SUFFIX, url)
GROUP BY
  _TABLE_SUFFIX
ORDER BY
  client,
  month,
  pct DESC
