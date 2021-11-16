SELECT
  client,
  ANY_VALUE(url) AS url,
  COUNT(0) AS count
FROM
  `httparchive.almanac.wasm_stats`
WHERE
  date = '2021-09-01'
GROUP BY
  client,
  filename
ORDER BY
  count DESC
