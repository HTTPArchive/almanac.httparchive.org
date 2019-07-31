#standardSQL

# input attributes

# dataset: `httparchive.pages.2019_07_01_mobile`
# sample: `httparchive.almanac.pages_desktop_1k`

CREATE TEMPORARY FUNCTION parseStructuredData(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  var attrs = [];
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    almanac['input-elements'] && almanac['input-elements'].map(function(node) {
        Object.keys(node).map(function(attr) {
            attrs.push(attr);
        });
    });
    return attrs;
  } catch (e) {
    return [];
  }
''';

SELECT
    flattened,
    COUNT(flattened) AS occurence,
    COUNT(flattened) / COUNT(url) AS occurence_perc
FROM
    `httparchive.almanac.pages_desktop_1k`
CROSS JOIN
    UNNEST(parseStructuredData(payload)) as flattened
GROUP BY flattened
ORDER BY occurence DESC
