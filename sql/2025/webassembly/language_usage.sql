# Query for the counts of language usage across wasm component.

SELECT
  client,
  JSON_VALUE(payload._wasm_stats.language) AS language,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS percentage
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  payload._wasm_stats IS NOT NULL
GROUP BY
  client,
  language
ORDER BY
  count DESC
