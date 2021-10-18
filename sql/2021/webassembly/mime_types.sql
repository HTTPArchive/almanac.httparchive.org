SELECT
  mimeType,
  COUNT(0) AS count
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  mimeType
ORDER BY
  count DESC
