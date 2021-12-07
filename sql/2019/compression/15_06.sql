#standardSQL
#15_06 - Text Based Compression Byte Savings
SELECT
  _TABLE_SUFFIX AS client,
  ROUND(CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.details.overallSavingsBytes") AS INT64) / 1024 / 1024) AS mbyte_savings,
  COUNT(0) AS num_pages,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX), 2) AS pct_pages
FROM
  `httparchive.lighthouse.2019_07_01_*`
WHERE
  JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") != "1"
GROUP BY
  client,
  mbyte_savings
ORDER BY
  client,
  mbyte_savings ASC
