#standardSQL
# 12_12: Popular input types
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
    ROUND(COUNT(input_type) * 100 / SUM(COUNT(0)) OVER (PARTITION BY 0), 2) AS occurence_perc,
    COUNT(DISTINCT url) AS pages,
    total AS total_pages,
    ROUND(COUNT(DISTINCT url) * 100 / total, 2) AS pages_perc
FROM
    `httparchive.pages.2019_07_01_mobile`,
    (SELECT COUNT(0) AS total FROM `httparchive.summary_pages.2019_07_01_mobile`),
    UNNEST(getInputTypes(payload)) AS input_type
GROUP BY input_type, total
ORDER BY occurence DESC
