#standardSQL
# Top manifest display values - based on 2019/14_04c.sql
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
  LOWER(getDisplay(body)) AS display,
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
  display
HAVING
  display IS NOT NULL
ORDER BY
  freq / total DESC,
  display,
  client
