#standardSQL
# CMS adoption per rank
# cms_adoption_by_rank.sql

SELECT
  client,
  technology,
  rank,
  COUNT(DISTINCT page) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT page) / ANY_VALUE(total) AS pct
FROM (
  SELECT DISTINCT
    client,
    technology,
    page
  FROM
    `httparchive.all.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    date = '2024-06-01' AND
    cats = 'CMS' AND
    is_root_page
)
JOIN (
  SELECT
    client,
    page,
    rank
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page
)
USING
  (client,
    page)
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
    rank_magnitude)
USING
  (client,
    rank),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
WHERE
  rank <= rank_magnitude
GROUP BY
  client,
  technology,
  rank
ORDER BY
  rank,
  pages DESC
