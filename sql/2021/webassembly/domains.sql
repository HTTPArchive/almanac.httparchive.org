SELECT
  client,
  COUNT(DISTINCT NET.REG_DOMAIN(url)) AS serving_domain_count,
  COUNT(DISTINCT NET.REG_DOMAIN(page)) AS consuming_domain_count
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
