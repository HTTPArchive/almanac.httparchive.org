#standardSQL
# % manifests preferring native apps - based on 2019/14_04e.sql
CREATE TEMPORARY FUNCTION prefersNative(manifest STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
try {
  var $ = JSON.parse(manifest);
  return $.prefer_related_applications == true && $.related_applications.length > 0;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  prefersNative(body) AS prefers_native,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.manifests`
WHERE
  date = '2020-08-01'
GROUP BY
  client,
  prefers_native
HAVING
  prefers_native IS NOT NULL
ORDER BY
  freq / total DESC
