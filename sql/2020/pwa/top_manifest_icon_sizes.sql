#standardSQL
# Top manifest icon sizes - based on 2019/14_04f.sql
CREATE TEMPORARY FUNCTION getIconSizes(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  var $ = JSON.parse(manifest);
  return $.icons.map(icon => icon.sizes);
} catch (e) {
  return null;
}
''';

SELECT
  client,
  size,
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
  UNNEST(getIconSizes(body)) AS size
GROUP BY
  client,
  size
HAVING
  size IS NOT NULL AND
  freq > 100
ORDER BY
  freq / total DESC,
  size,
  client
