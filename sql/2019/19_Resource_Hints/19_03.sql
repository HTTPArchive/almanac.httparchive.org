#standardSQL
# 19_03: Attribute popularity for each hint.
CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
var attributes = ['as', 'crossorigin'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return almanac['link-nodes'].reduce((results, link) => {
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
  _TABLE_SUFFIX AS client,
  hint.name,
  hint.attribute,
  IFNULL(NORMALIZE_AND_CASEFOLD(hint.value), 'not set') AS value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, hint.name) AS total,
  ROUND(COUNT(0) * 100 / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, hint.name), 2) AS pct
FROM
  `httparchive.pages.2019_07_01_*`,
  UNNEST(getResourceHints(payload)) AS hint
GROUP BY
  client,
  name,
  attribute,
  value
ORDER BY
  freq DESC