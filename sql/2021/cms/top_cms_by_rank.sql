#standardSQL
# CMS adoption per rank
SELECT
  client,
  cms,
  rank,
  COUNT(DISTINCT url) AS pages,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT url) / ANY_VALUE(total) AS pct
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app AS cms,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'CMS')
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    rank_magnitude AS rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
  WHERE
    rank <= rank_magnitude)
USING
  (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    rank_magnitude AS rank,
    COUNT(0) AS total
  FROM
    `httparchive.summary_pages.2021_07_01_*`,
    UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
  WHERE
    rank <= rank_magnitude
  GROUP BY
    _TABLE_SUFFIX,
    rank_magnitude)
USING
  (client, rank)
GROUP BY
  client,
  cms,
  rank
ORDER BY
  rank,
  pages DESC
