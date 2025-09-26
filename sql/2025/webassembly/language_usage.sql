# Query for the counts of language usage across wasm component.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload,'$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = '2025-07-01' AND type = 'wasm'
)

SELECT
  client,
  JSON_VALUE(wasm_stats.language) AS language,
  COUNT(0) AS count,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  wasm
WHERE
  wasm_stats IS NOT NULL
GROUP BY
  client,
  language
ORDER BY
  count DESC