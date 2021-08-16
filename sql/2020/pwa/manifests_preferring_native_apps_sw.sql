#standardSQL
# % manifests preferring native apps where service worker is used - based on 2019/14_04e.sql
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
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS pct
FROM
  (SELECT DISTINCT
    client,
    page,
    body
    FROM
      `httparchive.almanac.manifests`
    JOIN
      `httparchive.almanac.service_workers`
    USING
      (date, client, page)
    WHERE
      date = '2020-08-01')
GROUP BY
  client,
  prefers_native
HAVING
  prefers_native IS NOT NULL
ORDER BY
  client,
  prefers_native
