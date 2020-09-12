#standardSQL
# 11_04b: Manifests that are not JSON parsable
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
  `httparchive.almanac.manifests`
GROUP BY
  client,
  can_parse
ORDER BY
  freq DESC
