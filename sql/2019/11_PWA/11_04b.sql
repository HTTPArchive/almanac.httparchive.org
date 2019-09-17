#standardSQL
# 11_04b: Manifests that are not JSON parsable
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
  freq,
  total,
  ROUND(freq * 100 / total, 2) AS pct
FROM (
  SELECT
    client,
    COUNTIF(getManifestProps(body) IS NULL) AS freq,
    COUNT(DISTINCT page) AS total
  FROM
    `httparchive.almanac.manifests`
  GROUP BY
    client)