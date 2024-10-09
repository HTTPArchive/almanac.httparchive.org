# standardSQL
# Wasm module sizes, grouped by percentile at intervals of 0, 10, 25, 50, 75, 90, 100.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND (mimeType = 'application/wasm' OR ext = 'wasm')
)

SELECT
  percentile,
  client,
  APPROX_QUANTILES(respBodySize, 1000)[OFFSET(percentile * 10)] AS raw_size,
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
