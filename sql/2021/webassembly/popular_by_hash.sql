SELECT
  MIN(url) AS url,
  COUNT(*) AS count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  filename
ORDER BY
  count DESC