SELECT
  ext,
  COUNT(0) AS count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  ext
ORDER BY
  count DESC
