CREATE TEMPORARY FUNCTION getUnloadHandler(audit STRING)
RETURNS BOOL LANGUAGE js AS '''
try {
  var $ = JSON.parse(audit);
  return $.details?.items?.some(n => n.value?.toLowerCase() === "unloadhandler");
} catch (e) {
  return false;
}
''';

WITH lh AS (
  SELECT
    client,
    page,
    rank,
    getUnloadHandler(JSON_EXTRACT(lighthouse, '$.audits.deprecations')) AS has_unload
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
)


SELECT
  client,
  _rank AS rank,
  COUNTIF(has_unload) AS pages,
  COUNT(0) AS total,
  COUNTIF(has_unload) / COUNT(0) AS pct
FROM
  lh,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS _rank
WHERE
  rank <= _rank
GROUP BY
  client,
  rank
ORDER BY
  rank,
  client
