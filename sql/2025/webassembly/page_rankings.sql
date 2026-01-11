SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE CAST(rank_grouping AS STRING)
  END AS ranking,
  COUNT(DISTINCT page) AS pages
FROM
  `httparchive.crawl.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping
ORDER BY
  client,
  rank_grouping
