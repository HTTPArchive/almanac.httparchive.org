SELECT
  ext,
  COUNT(*) AS count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  ext
ORDER BY
  count DESC