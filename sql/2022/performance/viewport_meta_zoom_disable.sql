SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS total,
  SUM(IF(JSON_EXTRACT(report, '$.audits.meta-viewport.score') = '0', 1, 0 )) AS viewport_zoom_failed,
  SUM(IF(JSON_EXTRACT(report, '$.audits.meta-viewport.score') = '0', 1, 0 )) / COUNT(0) AS viewport_zoom_failed_per
FROM
  `httparchive.lighthouse.2022_06_01_*`
GROUP BY
  client
