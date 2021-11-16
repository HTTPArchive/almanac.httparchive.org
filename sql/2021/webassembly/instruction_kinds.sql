SELECT
  client,
  SUM(instr.categories.other) / SUM(instr.total) AS other_pct,
  SUM(instr.categories.constants) / SUM(instr.total) AS constants_pct,
  SUM(instr.categories.wait_notify) / SUM(instr.total) AS wait_notify_pct,
  SUM(instr.categories.indirect_calls) / SUM(instr.total) AS indirect_calls_pct,
  SUM(instr.categories.direct_calls) / SUM(instr.total) AS direct_calls_pct,
  SUM(instr.categories.load_store) / SUM(instr.total) AS load_store_pct,
  SUM(instr.categories.memory) / SUM(instr.total) AS memory_pct,
  SUM(instr.categories.control_flow) / SUM(instr.total) AS control_flow_pct,
  SUM(instr.categories.table) / SUM(instr.total) AS table_pct,
  SUM(instr.categories.global_var) / SUM(instr.total) AS global_var_pct,
  SUM(instr.categories.local_var) / SUM(instr.total) AS local_var_pct
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
ORDER BY
  client
