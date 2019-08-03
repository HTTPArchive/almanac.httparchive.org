#standardSQL

# input attributes occurence defined set %

CREATE TEMPORARY FUNCTION getInputAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  var attrs = [];
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);
    almanac['input-elements'] && almanac['input-elements'].forEach(function(node) {
        Object.keys(node).forEach(function(attr) {
            if (attr != 'tagName') attrs.push(attr);
        });
    });
    return attrs;
  } catch (e) {
    return [];
  }
''';

SELECT
    COUNTIF(REGEXP_CONTAINS(input_attributes, '/autocomplete|min|max|pattern|placeholder|required|step/i')) AS occurence,
    ROUND(COUNTIF(REGEXP_CONTAINS(input_attributes, '/autocomplete|min|max|pattern|placeholder|required|step/i')) * 100 / SUM(COUNT(0)) OVER (), 2) AS occurence_perc
FROM
    `httparchive.pages.2019_07_01_mobile`
CROSS JOIN
    UNNEST(getInputAttributes(payload)) as input_attributes
