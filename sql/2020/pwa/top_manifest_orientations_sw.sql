#standardSQL
# Top manifest orientations - based on 2019/14_04g.sql
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
  LOWER(getOrientation(body)) AS orientation,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM (
  SELECT DISTINCT
    client,
    body
  FROM
    `httparchive.almanac.manifests`
  JOIN
    `httparchive.almanac.service_workers`
  USING (date, client, page)
  WHERE
    date = '2020-08-01'
)
GROUP BY
  client,
  orientation
HAVING
  orientation IS NOT NULL
ORDER BY
  freq / total DESC,
  orientation,
  client
