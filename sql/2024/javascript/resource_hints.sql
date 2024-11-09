#standardSQL
# Returns the number of pages which have preload, prefetch or modulepreload for scripts
# resource_hints.sql
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
  COUNT(DISTINCT IF(script_hint, page, NULL)) AS pages,
  COUNT(DISTINCT page) AS total,
  COUNT(DISTINCT IF(script_hint, page, NULL)) / COUNT(DISTINCT page) AS pct
FROM (
  SELECT
    client,
    page,
    hint.name IN ('prefetch', 'preload', 'modulepreload') AND hint.value = 'script' AS script_hint
  FROM
    `httparchive.all.pages`
  LEFT JOIN
    UNNEST(getResourceHintAttrs(payload)) AS hint
  WHERE
    date = '2024-06-01'
)
GROUP BY
  client
