SELECT
  mimeType,
  COUNT(0) AS count
FROM
  `httparchive.almanac.wasm_stats`
GROUP BY
  mimeType
ORDER BY
  count DESC
