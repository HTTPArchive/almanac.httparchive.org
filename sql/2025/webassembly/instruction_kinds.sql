# Query for instructions kinds

SELECT
  client,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.other) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS other_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.constants) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS constants_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.wait_notify) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS wait_notify_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.indirect_calls) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS indirect_calls_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.direct_calls) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS direct_calls_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.load_store) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS load_store_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.memory) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS memory_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.control_flow) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS control_flow_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.table) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS table_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.global_var) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS global_var_pct,
  SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.categories.local_var) AS INT64)) / SUM(SAFE_CAST(JSON_VALUE(payload._wasm_stats.instr.total) AS INT64)) AS local_var_pct
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  payload._wasm_stats IS NOT NULL
GROUP BY
  client
ORDER BY
  client
