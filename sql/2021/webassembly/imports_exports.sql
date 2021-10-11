SELECT
  percentile,
  client,
  APPROX_QUANTILES(imports.tables, 1000)[OFFSET(percentile * 10)] AS imports_tables,
  APPROX_QUANTILES(imports.memories, 1000)[OFFSET(percentile * 10)] AS imports_memories,
  APPROX_QUANTILES(imports.globals, 1000)[OFFSET(percentile * 10)] AS imports_globals,
  APPROX_QUANTILES(imports.funcs, 1000)[OFFSET(percentile * 10)] AS imports_funcs,
  APPROX_QUANTILES(exports.tables, 1000)[OFFSET(percentile * 10)] AS exports_tables,
  APPROX_QUANTILES(exports.memories, 1000)[OFFSET(percentile * 10)] AS exports_memories,
  APPROX_QUANTILES(exports.globals, 1000)[OFFSET(percentile * 10)] AS exports_globals,
  APPROX_QUANTILES(exports.funcs, 1000)[OFFSET(percentile * 10)] AS exports_funcs
FROM
  `httparchive.almanac.wasm_stats`,
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
WHERE
  date = '2021-09-01'
GROUP BY
  percentile,
  client
ORDER BY
  percentile,
  client
