SELECT
  ROUND(SUM(instr.categories.other) / SUM(instr.total) * 1000) / 10 AS other_pct,
  ROUND(SUM(instr.categories.constants) / SUM(instr.total) * 1000) / 10 AS constants_pct,
  ROUND(SUM(instr.categories.wait_notify) / SUM(instr.total) * 1000) / 10 AS wait_notify_pct,
  ROUND(SUM(instr.categories.indirect_calls) / SUM(instr.total) * 1000) / 10 AS indirect_calls_pct,
  ROUND(SUM(instr.categories.direct_calls) / SUM(instr.total) * 1000) / 10 AS direct_calls_pct,
  ROUND(SUM(instr.categories.load_store) / SUM(instr.total) * 1000) / 10 AS load_store_pct,
  ROUND(SUM(instr.categories.memory) / SUM(instr.total) * 1000) / 10 AS memory_pct,
  ROUND(SUM(instr.categories.control_flow) / SUM(instr.total) * 1000) / 10 AS control_flow_pct,
  ROUND(SUM(instr.categories.TABLE) / SUM(instr.total) * 1000) / 10 AS table_pct,
  ROUND(SUM(instr.categories.global_var) / SUM(instr.total) * 1000) / 10 AS global_var_pct,
  ROUND(SUM(instr.categories.local_var) / SUM(instr.total) * 1000) / 10 AS local_var_pct
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
