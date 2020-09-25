#standardSQL
# Manifests that are not JSON parsable for service worker pages - based on 2019/14_04b.sql
CREATE TEMPORARY FUNCTION canParseManifest(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  JSON.parse(manifest);
  return true;
} catch (e) {
  return false;
}
''';

SELECT
  client,
  canParseManifest(body) AS can_parse,
  COUNT(DISTINCT page) AS freq,
  SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(DISTINCT page) * 100 / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client), 2) AS pct
FROM
  (SELECT DISTINCT
    m.client,
    m.page,
    m.body
  FROM
    `httparchive.almanac.manifests` m
  JOIN
    `httparchive.almanac.service_workers` sw
  USING
    (date, client, page)
  WHERE
    date = '2020-08-01')
GROUP BY
  client,
  can_parse
ORDER BY
  freq DESC
