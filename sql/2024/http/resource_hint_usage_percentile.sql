#standardSQL
CREATE TEMPORARY FUNCTION getResourceHints(link_nodes STRING)
RETURNS ARRAY<STRUCT<name STRING>>
LANGUAGE js AS '''
var hints = new Set(['dns-prefetch', 'preconnect', 'preload', 'prefetch', 'modulepreload']);
try {
  var linkNodes = JSON.parse(link_nodes);
  return linkNodes.nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    results.push({
      name: hint
    });
    return results;
  }, []);
} catch (e) {
  return [];
}
''';

SELECT
  client,
  is_root_page,
  percentile,
  APPROX_QUANTILES(dnsprefetch_hints, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS dnsprefetches,
  APPROX_QUANTILES(preconnect_hints, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS preconnects,
  APPROX_QUANTILES(prefetch_hints, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS prefetches,
  APPROX_QUANTILES(preload_hints, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS preloads,
  APPROX_QUANTILES(modulepreload_hints, 1000 IGNORE NULLS)[OFFSET(percentile * 10)] AS modulepreloads
FROM (
  SELECT
    client,
    is_root_page,
    page,
    SUM(dnsprefetch_hint) AS dnsprefetch_hints,
    SUM(preconnect_hint) AS preconnect_hints,
    SUM(prefetch_hint) AS prefetch_hints,
    SUM(preload_hint) AS preload_hints,
    SUM(modulepreload_hint) AS modulepreload_hints
  FROM (
    SELECT
      client,
      is_root_page,
      page,
      IF(hint.name = 'dns-prefetch', 1, 0) AS dnsprefetch_hint,
      IF(hint.name = 'preconnect', 1, 0) AS preconnect_hint,
      IF(hint.name = 'prefetch', 1, 0) AS prefetch_hint,
      IF(hint.name = 'preload', 1, 0) AS preload_hint,
      IF(hint.name = 'modulepreload', 1, 0) AS modulepreload_hint
    FROM
      `httparchive.all.pages`
    LEFT JOIN
      UNNEST(getResourceHints(JSON_QUERY(custom_metrics, '$.almanac.link-nodes'))) AS hint
    WHERE
      date = '2024-06-01'
    )
  GROUP BY
    client,
    is_root_page,
    page
  ),
  UNNEST([10, 25, 50, 75, 90, 100]) AS percentile
GROUP BY
  client,
  is_root_page,
  percentile
ORDER BY
  client,
  is_root_page,
  percentile
