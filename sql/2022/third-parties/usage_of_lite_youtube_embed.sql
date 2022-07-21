#standardSQL
# Percent of pages using lite-youtube-embed

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT IF(app = 'lite-youtube-embed', url, NULL)) AS freq,
  COUNT(DISTINCT url) AS total,
  COUNT(DISTINCT IF(app = 'lite-youtube-embed', url, NULL)) / COUNT(DISTINCT url) AS pct
FROM
  `httparchive.technologies.2022_06_01_*`
GROUP BY
  client
ORDER BY
  client
