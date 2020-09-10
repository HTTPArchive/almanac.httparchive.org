#standardSQL
# Top 500 manifest properties - based on 2019/14_04.sql
CREATE TEMPORARY FUNCTION getManifestProps(manifest STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  return Object.keys(JSON.parse(manifest));
} catch (e) {
  return null;
}
''';

SELECT
  client,
  property,
  COUNT(DISTINCT page) AS freq,
  total,
  ROUND(COUNT(DISTINCT page) * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    page,
    getManifestProps(body) AS properties,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.almanac.manifests`
  WHERE
    date = '2020-08-01'
  ),
  UNNEST(properties) AS property
GROUP BY
  client,
  total,
  property
ORDER BY
  freq / total DESC
LIMIT
  500
