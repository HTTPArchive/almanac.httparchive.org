#standardSQL
# Popular input attributes
CREATE TEMPORARY FUNCTION getInputAttributes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  const attrs = [];
  try {
    const almanac = JSON.parse(payload);
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
    const almanac = JSON.parse(payload);

    if (!almanac['input-elements']) {
      return false;
    }

    return almanac['input-elements'].length > 0;
  } catch (e) {
    return false;
  }
''';

SELECT
    total_pages_with_inputs,
    SUM(COUNT(0)) OVER () AS total_inputs,
    input_attributes,

    COUNT(input_attributes) AS occurence,
    COUNT(DISTINCT url) AS total_pages_using,
    COUNT(input_attributes) / SUM(COUNT(0)) OVER () AS occurence_perc,
    COUNT(DISTINCT url) / total_pages_with_inputs AS perc_of_pages_using
FROM
    `httparchive.pages.2021_07_01_mobile`,
    UNNEST(getInputAttributes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) as input_attributes,
    (SELECT COUNTIF(hasInputs(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS total_pages_with_inputs FROM `httparchive.pages.2021_07_01_mobile`)
GROUP BY
  input_attributes,
  total_pages_with_inputs
ORDER BY
  perc_of_pages_using DESC
LIMIT 1000
