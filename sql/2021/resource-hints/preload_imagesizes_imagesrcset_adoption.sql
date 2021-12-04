#standardSQL
# Attribute popularity for imagesrcset and imagesizes on rel="preload"

CREATE TEMPORARY FUNCTION getResourceHintAttrs(payload STRING)
RETURNS ARRAY<STRUCT<name STRING, attribute STRING, value STRING>>
LANGUAGE js AS '''
var hints = new Set(['preload']);
var attributes = ['imagesrcset', 'imagesizes'];
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
  _TABLE_SUFFIX AS client,
  hint.name AS name,
  hint.attribute AS attribute,
  COUNTIF(hint.value IS NOT NULL) AS freq,
  SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, hint.name) AS total,
  COUNTIF(hint.value IS NOT NULL) / SUM(COUNT(0)) OVER (PARTITION BY _TABLE_SUFFIX, hint.name) AS pct
FROM
  `httparchive.pages.2021_07_01_*`,
  UNNEST(getResourceHintAttrs(payload)) AS hint
GROUP BY
  client,
  name,
  attribute
ORDER BY
  client,
  name,
  attribute,
  pct DESC
