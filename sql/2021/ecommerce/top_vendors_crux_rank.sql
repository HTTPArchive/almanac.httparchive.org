#standardSQL
# Ranking top vendors in terms of top 10 all the way to top 10000000
# Uses the Crux rank field in the summary_pages table

#standardSQL
SELECT
  client,
  rank,
  app,
  COUNT(DISTINCT url) AS freq,
  total_pages,
  COUNT(DISTINCT url) / total_pages AS pct,
  COUNT(DISTINCT url) / rank AS rank_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce' AND
    app != 'Cart Functionality' AND
    app != 'Google Analytics Enhanced eCommerce')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_pages
  FROM
    `httparchive.summary_pages.2021_07_01_*`
  GROUP BY
    client)
USING
  (client)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    MAX(rank) AS rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([10, 100, 1000, 10000, 100000, 1000000, 10000000]) AS rank_magnitude
  WHERE
    rank <= rank_magnitude
  GROUP BY
    client,
    url)
USING
  (client, url)
GROUP BY
  client,
  rank,
  app,
  total_pages
ORDER BY
  rank,
  pct DESC
