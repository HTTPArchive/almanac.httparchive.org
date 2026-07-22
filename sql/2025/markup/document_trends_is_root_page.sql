SELECT
  date,
  client,
  APPROX_QUANTILES(INT64(summary.bytesHtml) / 1024, 1000)[OFFSET(500)] AS median_kbytes_html,
  COUNT(0) AS total
FROM
  `httparchive.crawl.pages`
WHERE
  date IN ('2022-06-01', '2023-06-01', '2024-06-01', '2025-07-01') AND
  is_root_page
GROUP BY
  date,
  client
ORDER BY
  date,
  client
