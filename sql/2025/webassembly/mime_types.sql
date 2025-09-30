# Query to get counts on various mimeType used in wasm component

SELECT
  client,
  JSON_VALUE(summary.mimeType) AS mimeType,
  COUNT(0) AS count
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  type = 'wasm'
GROUP BY
  client,
  mimeType
ORDER BY
  client,
  count DESC
