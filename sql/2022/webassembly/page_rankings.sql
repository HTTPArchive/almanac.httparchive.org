# standardSQL
# Count of pages which use wasm at page ranking intervals.

WITH wasm AS (
  SELECT
    *,
    JSON_QUERY(payload, '$._wasm_stats') AS wasm_stats
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2022-06-01' AND
    (mimeType = 'application/wasm' OR ext = 'wasm')
)

SELECT
  _rank AS rank,
  COUNT(DISTINCT page) AS pages
FROM
  `httparchive.scratchspace.wasm_stats`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  wasm_stats IS NOT NULL AND
  rank <= _rank
GROUP BY
  rank
ORDER BY
  rank
