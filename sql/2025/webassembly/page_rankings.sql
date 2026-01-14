# WASM usage by page ranking

WITH totals AS (
  SELECT
    client,
    rank_grouping,
    COUNT(DISTINCT root_page) AS total_sites
  FROM
    `httparchive.crawl.requests`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
  WHERE
    date = '2025-07-01' AND
    rank <= rank_grouping
  GROUP BY
    client,
    rank_grouping
  ORDER BY
    client,
    rank_grouping
)

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(DISTINCT root_page) AS sites,
  total_sites,
  COUNT(DISTINCT root_page) / total_sites AS pct_sites
FROM
  `httparchive.crawl.requests`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
INNER JOIN
  totals
USING (client, rank_grouping)
WHERE
  date = '2025-07-01' AND
  type = 'wasm' AND
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping,
  total_sites
ORDER BY
  client,
  rank_grouping
