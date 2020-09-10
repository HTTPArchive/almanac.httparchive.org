#standardSQL
# Top manifest categories - based on 2019/14_04d.sql
CREATE TEMPORARY FUNCTION getCategories(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(manifest);
  var categories = $.categories;
  if (typeof categories == 'string') {
    return [categories];
  }
  return categories;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  NORMALIZE_AND_CASEFOLD(category) AS category,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.manifests`,
  UNNEST(getCategories(body)) AS category
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  category
HAVING
  category IS NOT NULL
ORDER BY
  freq / total DESC
