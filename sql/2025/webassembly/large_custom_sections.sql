# Query to get largest custom size for wasm component

WITH wasm AS (
  SELECT
    client,
    url,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-06-01' AND (type = 'wasm')
)

SELECT
  client,
  ANY_VALUE(url) AS url,
  ANY_VALUE(JSON_VALUE(wasm_stats, '$.sections.custom')) AS custom_sections,
  MAX(SAFE_CAST(JSON_VALUE(wasm_stats, '$.size.custom') AS INT64)) AS custom_sections_size
  
FROM
  wasm
WHERE
  wasm_stats IS NOT NULL
GROUP BY
  client
ORDER BY
  client
