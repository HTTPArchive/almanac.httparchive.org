# Query to get count of pages which use wasm at page ranking intervals.

SELECT
  client,
  _rank AS rank,
  COUNT(DISTINCT page) AS pages
FROM
  `httparchive.crawl.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS _rank
WHERE
  date = '2025-06-01' AND type = 'wasm' AND rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank
