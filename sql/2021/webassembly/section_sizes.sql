SELECT
  client,
  ROUND(SUM(size.code) / SUM(size.total) * 1000) / 10 AS code_pct,
  ROUND(SUM(size.init) / SUM(size.total) * 1000) / 10 AS init_pct,
  ROUND(SUM(size.descriptors) / SUM(size.total) * 1000) / 10 AS descriptors_pct,
  ROUND(SUM(size.externals) / SUM(size.total) * 1000) / 10 AS externals_pct,
  ROUND(SUM(size.types) / SUM(size.total) * 1000) / 10 AS types_pct,
  ROUND(SUM(size.custom) / SUM(size.total) * 1000) / 10 AS custom_pct
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
