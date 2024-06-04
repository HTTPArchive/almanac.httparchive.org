#standardSQL
# Ranking top vendors in terms of top 10 all the way to top 10000000
# Uses the Crux rank field in the summary_pages table

#standardSQL
SELECT
  client,
  rank_grouping,
  CASE
    WHEN rank_grouping = 0 THEN ''
    WHEN rank_grouping = 10000000 THEN 'all'
    ELSE FORMAT("%'d", rank_grouping)
  END AS ranking,
  app,
  COUNT(DISTINCT url) AS freq,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2022_06_01_*`
  WHERE
    category = 'Ecommerce' AND (
      app != 'Cart Functionality' AND
      app != 'Google Analytics Enhanced eCommerce'
    )
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_grouping
  FROM
    `httparchive.summary_pages.2022_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    client,
    url,
    rank_grouping
)
USING (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_grouping,
    COUNT(DISTINCT url) AS total_pages
  FROM
    `httparchive.summary_pages.2022_06_01_*`,
    UNNEST([1000, 10000, 100000, 1000000, 10000000]) AS rank_grouping
  WHERE
    rank <= rank_grouping
  GROUP BY
    rank_grouping,
    client
)
USING (client, rank_grouping)
GROUP BY
  client,
  rank_grouping,
  app,
  total_pages
ORDER BY
  client,
  rank_grouping,
  pct DESC
