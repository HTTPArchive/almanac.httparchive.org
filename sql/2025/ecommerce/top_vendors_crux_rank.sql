#standardSQL
# Ecommerce adoption per rank
# top_ecommerce_by_rank.sql

SELECT
  client,
  ecommerce,
  rank_grouping,
  CASE
    WHEN rank_grouping = 100000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  COUNT(DISTINCT root_page) AS sites,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT root_page) / ANY_VALUE(total) AS pct
FROM (
  SELECT DISTINCT
    client,
    page,
    technologies.technology AS ecommerce
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'Ecommerce' AND
    date = '2025-07-01' AND
    technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
)
JOIN (
  SELECT
    client,
    page,
    root_page,
    rank_grouping
  FROM
    `httparchive.crawl.pages`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping AND
    date = '2025-07-01'
)
USING (client, page)
JOIN (
  SELECT
    client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping AND
    date = '2025-07-01'
  GROUP BY
    client,
    rank_grouping
)
USING (client, rank_grouping)
GROUP BY
  client,
  ecommerce,
  rank_grouping
ORDER BY
  rank_grouping,
  sites DESC
