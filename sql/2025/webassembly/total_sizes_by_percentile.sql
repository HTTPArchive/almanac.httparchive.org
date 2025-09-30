# Query to get size distribution by percentile

SELECT
  percentile,
  client,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.total) AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total
FROM
  `httparchive.crawl.requests`,
  UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  payload._wasm_stats IS NOT NULL
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
