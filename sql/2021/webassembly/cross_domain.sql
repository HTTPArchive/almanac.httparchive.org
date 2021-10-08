SELECT
  client,
  COUNTIF(NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url)) AS count_cross_origin,
  COUNT(*) AS total_count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  client