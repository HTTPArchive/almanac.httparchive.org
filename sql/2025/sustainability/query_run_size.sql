# standardSQL
# Monthly query run size average (MB) and total (TB)
# (0.012+0.013+0.081+0.055+0.0590.080)x494x [Total TB] *1024 = Total kg CO2e

SELECT
  AVG(
    CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
  ) / 1048576 AS avg_size_mb,
  SUM(
    CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64)
  ) / 1099511627776 AS total_size_tb
FROM
  `httparchive.crawl.pages`
WHERE
  date = '2025-07-01'
