#standardSQL
#Text Based Compression Byte Savings
SELECT
  _TABLE_SUFFIX AS client,
  IF(JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.score") != "1", 'compression', 'non_compression') AS compression,
  percents,
  APPROX_QUANTILES(( CAST(JSON_EXTRACT_SCALAR(report, "$.audits.uses-text-compression.details.overallSavingsBytes") AS INT64) / 1024), 1000)[OFFSET(percents * 10)] AS kbyte_savings
FROM
  `httparchive.lighthouse.2020_08_01_*`,
  unnest([10, 25, 50, 75, 90]) AS percents
WHERE
  report IS NOT NULL
GROUP BY
  _TABLE_SUFFIX,
  compression,
  percents
ORDER BY
  _TABLE_SUFFIX, percents ASC
