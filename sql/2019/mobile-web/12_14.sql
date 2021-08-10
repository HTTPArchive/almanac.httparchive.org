#standardSQL

# input attributes

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

CREATE TEMPORARY FUNCTION hasInputs(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    var $ = JSON.parse(payload);
    var almanac = JSON.parse($._almanac);

    if (!almanac['input-elements']) {
      return false;
    }

    return almanac['input-elements'].length;
  } catch (e) {
    return 0;
  }
''';

SELECT
    total_pages_with_inputs,
    SUM(COUNT(0)) OVER (PARTITION BY 0) AS total_inputs,
    input_attributes,

    COUNT(input_attributes) AS occurence,
    COUNT(DISTINCT url) AS total_pages_using,
    ROUND(COUNT(input_attributes) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS occurence_perc,
    ROUND(COUNT(DISTINCT url) * 100 / total_pages_with_inputs, 2) AS perc_of_pages_using
FROM
    `httparchive.pages.2019_07_01_mobile`,
    UNNEST(getInputAttributes(payload)) AS input_attributes,
    (SELECT COUNTIF(hasInputs(payload)) AS total_pages_with_inputs FROM `httparchive.pages.2019_07_01_mobile`)
GROUP BY input_attributes, total_pages_with_inputs
ORDER BY perc_of_pages_using DESC
LIMIT 1000
