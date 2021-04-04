#standardSQL
# 11_04c: Top manifest display values
CREATE TEMPORARY FUNCTION getDisplay(manifest STRING)
RETURNS STRING LANGUAGE js AS '''
try {
  var $ = JSON.parse(manifest);
  if (!('display' in $)) {
    return '(not set)';
  }
  return $.display;
} catch (e) {
  return null;
}
''';

SELECT
  client,
  getDisplay(body) AS display,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY client), 2) AS pct
FROM
  `httparchive.almanac.manifests`
WHERE
  date = '2019-07-01'
GROUP BY
  client,
  display
HAVING
  display IS NOT NULL
ORDER BY
  freq / total DESC
