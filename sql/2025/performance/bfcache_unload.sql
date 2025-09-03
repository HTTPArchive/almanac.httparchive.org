CREATE TEMPORARY FUNCTION getUnloadHandler(items JSON)
RETURNS BOOL LANGUAGE js AS '''
try {
  return items?.some(n => n.value?.toLowerCase()?.includes("unload event listeners"));
} catch (e) {
  return false;
}
''';

WITH lh AS (
  SELECT
    client,
    page,
    rank,
    getUnloadHandler(lighthouse.audits.deprecations.details.items) AS has_unload
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  ranking,
  COUNTIF(has_unload) AS pages,
  COUNT(0) AS total,
  COUNTIF(has_unload) / COUNT(0) AS pct
FROM
  lh,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS ranking
WHERE
  rank <= ranking
GROUP BY
  client,
  ranking
ORDER BY
  ranking,
  client
