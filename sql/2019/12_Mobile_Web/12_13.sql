#standardSQL

# input types occurence prefined set %

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
    COUNTIF(REGEXP_CONTAINS(input_types, '/color|date|datetime-local|email|month|number|range|reset|search|tel|time|url|week|datalist/i')) AS occurence,
    ROUND(COUNT(REGEXP_CONTAINS(input_types, '/color|date|datetime-local|email|month|number|range|reset|search|tel|time|url|week|datalist/i')) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_mobile`
CROSS JOIN
    UNNEST(getInputTypes(payload)) as input_types
