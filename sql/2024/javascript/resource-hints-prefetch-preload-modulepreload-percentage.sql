#standardSQL
CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'modulepreload']);
var attributes = ['as'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].nodes.reduce((results, link) => {
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
  COUNT(DISTINCT IF(prefetch_hint, page, NULL)) AS prefetch_pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(prefetch_hint, page, NULL)) / COUNT(DISTINCT page) AS prefetch_pct,
  COUNT(DISTINCT IF(preload_hint, page, NULL)) AS preload_pages,
  COUNT(DISTINCT IF(preload_hint, page, NULL)) / COUNT(DISTINCT page) AS preload_pct,
  COUNT(DISTINCT IF(modulepreload_hint, page, NULL)) AS modulepreload_pages,
  COUNT(DISTINCT IF(modulepreload_hint, page, NULL)) / COUNT(DISTINCT page) AS modulepreload_pct
FROM (
  SELECT
    client,
    page,
    hint.name = 'prefetch' AND hint.value = 'script' AS prefetch_hint,
    hint.name = 'preload' AND hint.value = 'script' AS preload_hint,
    hint.name = 'modulepreload' AND hint.value = 'script' AS modulepreload_hint
  FROM
    `httparchive.all.pages`
  LEFT JOIN
    UNNEST(getResourceHintAttrs(payload)) AS hint
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client
