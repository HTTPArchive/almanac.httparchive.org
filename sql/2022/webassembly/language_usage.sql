# standardSQL
# The counts of language usage across wasm modules.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND (mimeType = 'application/wasm' OR ext = 'wasm')
)

SELECT
  client,
  JSON_VALUE(wasm_stats, '$.language') AS language,
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
