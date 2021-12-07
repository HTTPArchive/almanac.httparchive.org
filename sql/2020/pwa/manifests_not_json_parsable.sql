#standardSQL
# Manifests that are not JSON parsable - based on 2019/14_04b.sql
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
  COUNT(DISTINCT page) / SUM(COUNT(DISTINCT page)) OVER (PARTITION BY client) AS pct
FROM
  (SELECT DISTINCT
    client,
    page,
    body
    FROM
      `httparchive.almanac.manifests`
    WHERE
      date = '2020-08-01')
GROUP BY
  client,
  can_parse
ORDER BY
  freq DESC
