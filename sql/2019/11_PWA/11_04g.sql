#standardSQL
# 11_04g: Top manifest orientations
CREATE TEMPORARY FUNCTION getOrientation(manifest STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var $ = JSON.parse(manifest);
  if (!('orientation' in $)) {
    return '(not set)';
  }
  return $.orientation;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  getOrientation(body) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.manifests`
GROUP BY
  client,
  orientation
HAVING
  orientation IS NOT NULL
ORDER BY
  freq / total DESC