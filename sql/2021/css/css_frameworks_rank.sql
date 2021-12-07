#standardSQL
# Most popular CSS frameworks by rank
SELECT
  client,
  framework,
  rank,
  COUNT(DISTINCT page) AS pages,
  COUNT(DISTINCT page) / rank AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    rank AS _rank
  FROM
    `httparchive.summary_pages.2021_07_01_*`)
LEFT JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app AS framework,
    url AS page
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'UI frameworks')
USING
  (client, page),
  UNNEST([1e3, 1e4, 1e5, 1e6, 1e7]) AS rank
WHERE
  _rank <= rank
GROUP BY
  client,
  framework,
  rank
ORDER BY
  rank,
  pct DESC
