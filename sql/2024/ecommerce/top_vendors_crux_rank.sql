#standardSQL
# Ecommerce adoption per rank
# top_ecommerce_by_rank.sql

SELECT
  client,
  ecommerce,
  rank,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct
FROM (
  SELECT DISTINCT
    client,
    page AS url,
    technologies.technology AS ecommerce
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    cats = 'Ecommerce' AND
    date = '2024-06-01' AND
    is_root_page AND
    technologies.technology NOT IN ('Cart Functionality', 'Google Analytics Enhanced eCommerce')
)
JOIN (
  SELECT
    client,
    page AS url,
    rank_magnitude AS rank
  FROM
    `httparchive.all.pages`,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
  WHERE
    rank <= rank_magnitude AND
    date = '2024-06-01' AND
    is_root_page
)
USING (client, url)
JOIN (
  SELECT
    client,
    rank_magnitude AS rank,
    COUNT(0) AS total
  FROM
    `httparchive.all.pages`,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
  WHERE
    rank <= rank_magnitude AND
    date = '2024-06-01' AND
    is_root_page
  GROUP BY
    client,
    rank_magnitude
)
USING (client, rank)
GROUP BY
  client,
  ecommerce,
  rank
ORDER BY
  rank,
  pages DESC
