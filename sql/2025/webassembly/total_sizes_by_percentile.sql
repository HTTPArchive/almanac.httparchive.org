# Query to get size distribution by percentile

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-06-01' AND (type = 'wasm')
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64), 1000)[OFFSET(percentile * 10)] AS size_total
FROM
  wasm,
  UNNEST([0, 10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  wasm_stats IS NOT NULL
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
