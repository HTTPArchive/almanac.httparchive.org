#standardSQL
SELECT
  _TABLE_SUFFIX AS client,
  rank_grouping,
  total_in_rank,
  category,
  app,
  COUNT(0) AS pages_with_app,
  COUNT(0) / total_in_rank AS pct_pages_with_app
FROM (
  SELECT
    _TABLE_SUFFIX,
    app,
    category,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = 'static site generator' OR
    app = 'Next.js' OR
    app = 'Nuxt.js'
)
LEFT OUTER JOIN (
  SELECT
    _TABLE_SUFFIX,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
) USING (_TABLE_SUFFIX, url)
JOIN (
  SELECT
    _TABLE_SUFFIX,
    rank_grouping,
    COUNT(0) AS total_in_rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    _TABLE_SUFFIX,
    rank_grouping
) USING (_TABLE_SUFFIX, rank_grouping)
GROUP BY
  client,
  rank_grouping,
  total_in_rank,
  category,
  app
ORDER BY
  pct_pages_with_app DESC,
  app,
  rank_grouping
