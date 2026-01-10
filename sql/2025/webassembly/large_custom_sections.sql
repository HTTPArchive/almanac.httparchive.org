# Query to get largest custom size for wasm component

SELECT
  client,
  ANY_VALUE(url) AS url,
  ANY_VALUE(JSON_VALUE(payload._wasm_stats.sections.custom)) AS custom_sections,
  MAX(SAFE_CAST(JSON_VALUE(payload._wasm_stats.size.custom) AS INT64)) AS custom_sections_size
FROM
  `httparchive.crawl.requests`
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  payload._wasm_stats IS NOT NULL
GROUP BY
  client
ORDER BY
  client
