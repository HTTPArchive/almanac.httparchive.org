CREATE TEMPORARY FUNCTION getUnloadHandler(items JSON)
RETURNS BOOL LANGUAGE js AS '''
try {
  return items?.some((item) => {
    const value = item.value?.toLowerCase();

    // NOTE: Lighthouse uses different values for deprecation items
    // depending on which version HTTP Archive used
    // at the time the data was collected.

    // Lighthouse <= v12.3.0
    // NOTE: If you don't need data before 2025-03-01, you can remove this.
    if (value === "unloadhandler") {
      return true;
    }

    // Lighthouse >= v12.4.0 (2025-03-01)
    // https://github.com/GoogleChrome/lighthouse/pull/16333
    return value?.includes("unload event listeners");
  });
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
