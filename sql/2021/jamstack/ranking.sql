#standardSQL
SELECT
  client,
  rank,
  app,
  COUNT(DISTINCT url) AS pages,
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
    LOWER(category) = 'static site generator' OR
    app = 'Next.js' OR
    app = 'Nuxt.js')
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
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
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
