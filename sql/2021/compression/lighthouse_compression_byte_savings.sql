#standardSQL
# lighthouse_compression_byte_savings.sql :  Text Based Compression Byte Savings
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.details.overallSavingsBytes") AS INT64) / 1024 / 1024) AS mbyte_savings,
  COUNT(0) AS num_pages,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX) AS pct_pages
FROM
  `httparchive.lighthouse.2021_07_01_*`
WHERE
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") != "1"
GROUP BY
  client,
  mbyte_savings
ORDER BY
  client,
  mbyte_savings
