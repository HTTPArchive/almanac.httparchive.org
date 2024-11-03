SELECT
  date,
  client,
  COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.audits.render-blocking-resources.score') AS FLOAT64) >= 0.9) AS is_passing,
  COUNT(0) AS total,
  COUNTIF(SAFE_CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.audits.render-blocking-resources.score') AS FLOAT64) >= 0.9) / COUNT(0) AS pct_passing
FROM
  `httparchive.all.pages`
WHERE
  date IN ('2022-06-01', '2023-06-01', '2024-06-01') AND
  is_root_page
GROUP BY
  date,
  client
