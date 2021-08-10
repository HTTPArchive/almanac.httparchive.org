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
  COUNT(DISTINCT page) / total AS pct
FROM (
  SELECT
    client,
    page,
    getManifestProps(m.body) AS properties,
    COUNT(DISTINCT m.page) OVER (PARTITION BY client) AS total
  FROM
    `httparchive.almanac.manifests`
  JOIN
    `httparchive.almanac.service_workers`
  USING
    (date, client, page)
  WHERE
    date = '2020-08-01'
  ),
  UNNEST(properties) AS property
GROUP BY
  client,
  total,
  property
HAVING
  freq > 10
ORDER BY
  freq / total DESC,
  property,
  client
