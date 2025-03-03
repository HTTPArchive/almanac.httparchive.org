#standardSQL
# Percent of pages using webpack grouped by rank

SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNTIF('Webpack' IN UNNEST(technologies.technology)) AS webpack_pages,
  COUNT(0) AS total_pages,
  COUNTIF('Webpack' IN UNNEST(technologies.technology)) / COUNT(0) AS pct_webpack_pages
FROM
  `httparchive.crawl.pages`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  date = '2024-06-01' AND
  is_root_page AND
  rank <= rank_grouping
GROUP BY
  client,
  rank_grouping,
  ranking
ORDER BY
  client,
  rank_grouping
