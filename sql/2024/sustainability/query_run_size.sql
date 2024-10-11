SELECT 
  AVG(CAST(JSON_VALUE(summary, "$.bytesTotal") AS INT64)) / 1048576 AS avg_size_MB,
  SUM(CAST(JSON_VALUE(summary, "$.bytesTotal") AS INT64)) / 1099511627776 AS total_size_TB
FROM 
  `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
