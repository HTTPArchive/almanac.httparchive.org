#standardSQL
# Percent of pages using Partytown

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(DISTINCT IF(app = 'Partytown', url, NULL)) AS freq,
  COUNT(DISTINCT url) AS total,
  COUNT(DISTINCT IF(app = 'Partytown', url, NULL)) / COUNT(DISTINCT url) AS pct
FROM
  `httparchive.technologies.2022_06_01_*`
GROUP BY
  client
ORDER BY
  client
