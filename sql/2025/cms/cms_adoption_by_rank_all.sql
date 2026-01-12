#standardSQL
# CMS adoption per rank
SELECT
  client,
  rank_grouping,
  CASE rank_grouping
    WHEN 1e8 THEN 'all'
    ELSE TRIM(CAST(rank_grouping AS STRING FORMAT '99,999,999'))
  END AS rank_grouping_text,
  COUNT(DISTINCT page) AS pages,
  MAX(total) AS total,
  COUNT(DISTINCT page) / MAX(total) AS pct
FROM (
  SELECT
    client,
    page,
    rank_grouping
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS tech,
    UNNEST(tech.categories) AS category,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7, 1e8]) AS rank_grouping
  WHERE
    date = '2025-06-01' AND
    rank <= rank_grouping AND
    is_root_page AND
    category = 'CMS'
)
JOIN (
  SELECT
    client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.crawl.pages`,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7, 1e8]) AS rank_grouping
  WHERE
    date = '2025-06-01' AND
    rank <= rank_grouping AND
    is_root_page
  GROUP BY
    client,
    rank_grouping
)
USING (client, rank_grouping)
GROUP BY
  client,
  rank_grouping
ORDER BY
  rank_grouping,
  pages DESC
