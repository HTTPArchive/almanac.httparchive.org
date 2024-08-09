SELECT
  client,
  COUNTIF(JSON_VALUE(lighthouse, '$.audits.viewport.score') = '0') AS viewport_failed,
  COUNT(*) AS total,
  COUNTIF(JSON_VALUE(lighthouse, '$.audits.viewport.score') = '0') / COUNT(*) AS pct_failed
FROM
  `httparchive.all.pages`
WHERE
  date = '2024-06-01' AND
  is_root_page
GROUP BY
  client
