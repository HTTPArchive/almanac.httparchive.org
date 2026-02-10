# Query to get raw size, striped and optimized size distribution by client and percentile

SELECT
  percentile,
  client,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.raw_size) AS INT64), 1000)[OFFSET(percentile * 10)] AS raw_size,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_br) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total_br,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_strip) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total_strip,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_strip_br) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total_strip_br,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_opt) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total_opt,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_opt_br) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total_opt_br,
  APPROX_QUANTILES((SAFE_CAST(JSON_VALUE(payload._wasm_stats.raw_size) AS INT64) - SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_br) AS INT64)), 1000)[OFFSET(percentile * 10)] AS br_savings,
  APPROX_QUANTILES((SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_br) AS INT64) - SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_strip_br) AS INT64)), 1000)[OFFSET(percentile * 10)] AS strip_br_savings,
  APPROX_QUANTILES((SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_strip_br) AS INT64) - SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_opt_br) AS INT64)), 1000)[OFFSET(percentile * 10)] AS opt_br_savings,
  APPROX_QUANTILES((SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_strip) AS INT64) - SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total_opt) AS INT64)), 1000)[OFFSET(percentile * 10)] AS opt_savings
FROM
  `httparchive.crawl.requests`,
  UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client