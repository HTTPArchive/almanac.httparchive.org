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
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT DISTINCT
    client,
    body
  FROM
    `httparchive.almanac.manifests`
  WHERE
    date = '2020-08-01'
),
  UNNEST(getCategories(body)) AS category
GROUP BY
  client,
  category
HAVING
  category IS NOT NULL
ORDER BY
  freq / total DESC,
  category,
  client
