#standardSQL
  # CMS adoption per rank
SELECT
  _TABLE_SUFFIX AS client,
  rank,
  COUNT(0) AS freq,
  ANY_VALUE(total) AS total,
  COUNT(0) / ANY_VALUE(total) AS pct
FROM (
  SELECT DISTINCT
    _TABLE_SUFFIX,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'CMS')
JOIN (
  SELECT
    _TABLE_SUFFIX,
    url,
    rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`)
USING
  (_TABLE_SUFFIX, url)
JOIN (
  SELECT
    _TABLE_SUFFIX,
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
  (_TABLE_SUFFIX, rank),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank_magnitude
WHERE
  rank <= rank_magnitude
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
