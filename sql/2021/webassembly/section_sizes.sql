SELECT
  client,
  SUM(size.code) / SUM(size.total) AS code_pct,
  SUM(size.init) / SUM(size.total) AS init_pct,
  SUM(size.descriptors) / SUM(size.total) AS descriptors_pct,
  SUM(size.externals) / SUM(size.total) AS externals_pct,
  SUM(size.types) / SUM(size.total) AS types_pct,
  SUM(size.custom) / SUM(size.total) AS custom_pct
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
ORDER BY
  client
