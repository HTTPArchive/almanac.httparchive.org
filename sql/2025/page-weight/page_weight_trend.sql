SELECT
  date,
  client,
  is_root_page,
  ROUND(APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesTotal) AS INT64), 1000)[OFFSET(100)] / 1024, 2) AS p10,
  ROUND(APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesTotal) AS INT64), 1000)[OFFSET(250)] / 1024, 2) AS p25,
  ROUND(APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesTotal) AS INT64), 1000)[OFFSET(500)] / 1024, 2) AS p50,
  ROUND(APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesTotal) AS INT64), 1000)[OFFSET(750)] / 1024, 2) AS p75,
  ROUND(APPROX_QUANTILES(CAST(JSON_VALUE(summary.bytesTotal) AS INT64), 1000)[OFFSET(900)] / 1024, 2) AS p90
FROM
  `httparchive.crawl.pages`
WHERE
  date >= '2011-07-01' AND date <= '2025-07-01' AND
  CAST(JSON_VALUE(summary.bytesTotal) AS INT64) > 0
GROUP BY
  date,
  client,
  is_root_page
ORDER BY
  date DESC,
  client,
  is_root_page
