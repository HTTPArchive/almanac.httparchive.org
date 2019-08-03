#standardSQL

# input types

# dataset: `httparchive.pages.2019_07_01_mobile`
# sample: `httparchive.almanac.pages_desktop_1k`

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    return almanac['input-elements'] && almanac['input-elements'].map(function(node) {
        return node.type.toLowerCase();
    });
  } catch (e) {
    return [];
  }
''';

SELECT
    flattened,
    COUNT(flattened) AS occurence,
    ROUND(COUNT(flattened) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.almanac.pages_desktop_1k`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) as flattened
GROUP BY flattened
ORDER BY occurence DESC
