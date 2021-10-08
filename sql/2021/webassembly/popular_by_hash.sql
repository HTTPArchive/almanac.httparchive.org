SELECT
  MIN(url) AS url,
  COUNT(0) AS count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  filename
ORDER BY
  count DESC
