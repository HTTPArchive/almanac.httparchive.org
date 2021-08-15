SELECT
  _TABLE_SUFFIX AS client,
  cdn,
  COUNT(0) AS n,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct
FROM
  `httparchive.summary_pages.2021_07_01_*`,
  UNNEST(SPLIT(cdn, ', ')) AS cdn
GROUP BY
  client,
  cdn
ORDER BY
  pct DESC
