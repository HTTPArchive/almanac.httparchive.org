# standardSQL
# Count of pages which use wasm at page ranking intervals.

SELECT
  client,
  _rank AS rank,
  COUNT(DISTINCT page) AS pages
FROM
  `httparchive.almanac.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  date = '2022-06-01' AND (mimeType = 'application/wasm' OR ext = 'wasm') AND
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank
