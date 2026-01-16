SELECT
  client,
  date,
  EXTRACT(YEAR FROM date) AS year,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(DISTINCT root_page) AS ecommerce_sites,
  total,
  COUNT(DISTINCT root_page) / total AS pct_ecommerce
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS technologies,
  UNNEST(technologies.categories) AS cats,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
JOIN (
  SELECT
    date,
    client,
    rank_grouping,
    COUNT(DISTINCT root_page) AS total
  FROM
    `httparchive.crawl.pages`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
  WHERE
    date IN ('2025-07-01', '2024-06-01', '2023-07-01', '2022-06-01', '2025-07-01') AND
    rank <= rank_grouping
  GROUP BY
    date,
    client,
    rank_grouping
)
USING (date, client, rank_grouping)
WHERE
  date IN ('2025-07-01', '2024-06-01', '2023-07-01', '2022-06-01', '2025-07-01') AND
  rank <= rank_grouping AND
  cats = 'Ecommerce' AND
  technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
GROUP BY
  date,
  client,
  rank_grouping,
  total
ORDER BY
  date DESC,
  client,
  rank_grouping
