#standardSQL
CREATE TEMPORARY FUNCTION getResourceHints(link_nodes STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preconnect', 'preload', 'prefetch', 'modulepreload']);
var attributes = ['as'];
try {
  var linkNodes = JSON.parse(link_nodes);
  return linkNodes.nodes.reduce((results, link) => {
    var hint = link.rel.toLowerCase();
    if (!hints.has(hint)) {
      return results;
    }
    attributes.forEach(attribute => {
      var value = link[attribute];
      results.push({
        name: hint,
        attribute: attribute,
        // Support empty strings.
        value: typeof value == 'string' ? value : null
      });
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
  page,
  SUM(preconnect_hint) AS dnsprefetch_hints,
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
HAVING
  dnsprefetch_hints > 1000 OR
  preconnect_hints > 1000 OR
  prefetch_hints > 1000 OR
  preload_hints > 1000 OR
  modulepreload_hints > 1000
ORDER BY
  preload_hints DESC,
  modulepreload_hints DESC,
  prefetch_hints DESC,
  preconnect_hints DESC,
  dnsprefetch_hints DESC
