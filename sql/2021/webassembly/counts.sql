SELECT
  client,
  COUNT(0) AS total_count,
  COUNT(DISTINCT filename) AS distinct_count
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client
ORDER BY
  client
