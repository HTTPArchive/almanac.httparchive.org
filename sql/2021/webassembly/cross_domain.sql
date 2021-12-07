SELECT
  client,
  COUNTIF(NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url)) / COUNT(0) AS cross_origin_pct
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
ORDER BY
  client
