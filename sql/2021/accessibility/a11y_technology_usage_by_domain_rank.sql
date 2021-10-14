#standardSQL
# A11Y technology usage by domain rank
SELECT
  client,
  rank_grouping,
  total_in_rank,

  app,
  COUNT(0) AS sites_with_app,
  COUNT(0) / total_in_rank AS pct_sites_with_app
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = "Accessibility"
)
LEFT OUTER JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
) USING (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    COUNT(0) AS total_in_rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    client,
    rank_grouping
) USING (client, rank_grouping)
GROUP BY
  rank_grouping,
  total_in_rank,
  client,
  app
ORDER BY
  app,
  rank_grouping,
  client
