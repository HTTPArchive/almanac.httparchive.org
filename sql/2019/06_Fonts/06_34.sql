#standardSQL
# 06_34: Web fonts loaded per page
SELECT
  _TABLE_SUFFIX AS client,
  reqFont AS fonts,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct
FROM
  `httparchive.summary_pages.2019_07_01_*`
GROUP BY
  client,
  fonts
ORDER BY
  freq / total DESC
