#standardSQL
CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch']);
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
  COUNT(DISTINCT IF(preload_hint, page, NULL)) / COUNT(DISTINCT page) AS preload_pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    url AS page,
    hint.name = 'prefetch' AND hint.value = 'script' AS prefetch_hint,
    hint.name = 'preload' AND hint.value = 'script' AS preload_hint
  FROM
    `httparchive.pages.2021_07_01_*`
  LEFT JOIN
    UNNEST(getResourceHintAttrs(payload)) AS hint
)
GROUP BY
  client
