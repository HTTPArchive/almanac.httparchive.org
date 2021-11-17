#standardSQL
# Attribute popularity for each hint.

CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch']);
var attributes = ['as', 'crossorigin', 'media'];
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
''' ;

SELECT
  client,
  name,
  attribute,
  value,
  COUNT(0) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY client, name, attribute) AS total,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client, name, attribute) AS pct
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    hint.name AS name,
    hint.attribute AS attribute,
    IFNULL(TRIM(NORMALIZE_AND_CASEFOLD(hint.value)), 'not set') AS value
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(getResourceHintAttrs(payload)) AS hint
)
GROUP BY
  client,
  name,
  attribute,
  value
ORDER BY
  client,
  name,
  attribute,
  value,
  pct DESC
