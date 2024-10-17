#standardSQL
CREATE TEMPORARY FUNCTION getResourceHints(link_nodes STRING)
RETURNS ARRAY<STRUCT<name STRING>>
LANGUAGE js AS '''
var hints = new Set(['dns-prefetch', 'preconnect', 'preload', 'prefetch', 'modulepreload']);
var attributes = ['as'];
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
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(dnsprefetch_hints > 0, page, NULL)) AS dnsprefetch_pages,
  COUNT(DISTINCT IF(dnsprefetch_hints > 0, page, NULL)) / COUNT(DISTINCT page) AS dnsprefetch_pct,
  COUNT(DISTINCT IF(preconnect_hints > 0, page, NULL)) AS preconnect_pages,
  COUNT(DISTINCT IF(preconnect_hints > 0, page, NULL)) / COUNT(DISTINCT page) AS preconnect_pct,
  COUNT(DISTINCT IF(prefetch_hints > 0, page, NULL)) AS prefetch_pages,
  COUNT(DISTINCT IF(prefetch_hints > 0, page, NULL)) / COUNT(DISTINCT page) AS prefetch_pct,
  COUNT(DISTINCT IF(preload_hints > 0, page, NULL)) AS preload_pages,
  COUNT(DISTINCT IF(preload_hints > 0, page, NULL)) / COUNT(DISTINCT page) AS preload_pct,
  COUNT(DISTINCT IF(modulepreload_hints > 0, page, NULL)) AS modulepreload_pages,
  COUNT(DISTINCT IF(modulepreload_hints > 0, page, NULL)) / COUNT(DISTINCT page) AS modulepreload_pct
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
      UNNEST(getResourceHints(JSON_EXTRACT(custom_metrics, '$.almanac.link-nodes'))) AS hint
    WHERE
      date = '2024-06-01'
    )
  GROUP BY
    client,
    is_root_page,
    page
)
GROUP BY
  client,
  is_root_page
