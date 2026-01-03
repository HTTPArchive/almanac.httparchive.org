# Query to get count of pages which use wasm at page ranking intervals.

SELECT
  client,
  _rank AS rank_grouping,
  CASE
    WHEN _rank = 100000000 THEN 'all'
    ELSE CAST(_rank AS STRING)
  END AS ranking,
  COUNT(DISTINCT page) AS pages
FROM
  `httparchive.crawl.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS _rank
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank
