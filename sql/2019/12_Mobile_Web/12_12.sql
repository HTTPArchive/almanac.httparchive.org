#standardSQL

# input types

CREATE TEMPORARY FUNCTION getInputTypes(payload STRING)
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
    input_type,
    COUNT(input_type) AS occurence,
    ROUND(COUNT(input_type) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_mobile`
CROSS JOIN
    UNNEST(getInputTypes(payload)) as input_type
GROUP BY input_type
ORDER BY occurence DESC
