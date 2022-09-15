# standardSQL
# Size distribution of each wasm section type.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    (mimeType = 'application/wasm' OR ext = 'wasm')
)

SELECT
  client,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.code') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS code_pct,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.init') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS init_pct,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.descriptors') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS descriptors_pct,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.externals') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS externals_pct,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.types') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS types_pct,
  SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.custom') AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.total') AS INT64)) AS custom_pct
FROM
  wasm
WHERE
  wasm_stats IS NOT NULL
GROUP BY
  client
ORDER BY
  client
