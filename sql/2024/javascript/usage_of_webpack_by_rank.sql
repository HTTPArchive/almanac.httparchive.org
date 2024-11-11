#standardSQL
# Percent of pages using webpack grouped by rank

WITH webpack_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page
  FROM
    `httparchive.technologies.2024_06_01_*`
  WHERE
    lower(app) = 'webpack'
),

rank_totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2024_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    client,
    rank_grouping
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    url AS page
  FROM
    `httparchive.summary_pages.2024_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
)

SELECT
  client,
  rank_grouping AS rank,
  COUNT(DISTINCT webpack_pages.page) AS count_webpack_pages,
  total,
  COUNT(DISTINCT webpack_pages.page) / total AS pct_webpack_pages
FROM
  webpack_pages
LEFT OUTER JOIN
  pages
USING (client, page)
JOIN
  rank_totals
USING (client, rank_grouping)
GROUP BY
  client,
  total,
  rank_grouping
ORDER BY
  client,
  rank_grouping
