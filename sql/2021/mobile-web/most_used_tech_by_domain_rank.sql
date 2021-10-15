#standardSQL
# Most used technologies by domain rank - mobile only
SELECT
  rank_grouping,
  total_in_rank,

  category,
  app,
  COUNT(0) AS pages_with_app,
  COUNT(0) / total_in_rank AS pct_pages_with_app
FROM (
  SELECT
    app,
    category,
    url
  FROM
    `httparchive.technologies.2021_07_01_mobile`
)
LEFT OUTER JOIN (
  SELECT
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
) USING (url)
JOIN (
  SELECT
    rank_grouping,
    COUNT(0) AS total_in_rank
  FROM
    `httparchive.summary_pages.2021_07_01_mobile`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    rank_grouping
) USING (rank_grouping)
GROUP BY
  rank_grouping,
  total_in_rank,
  category,
  app
ORDER BY
  app,
  rank_grouping
