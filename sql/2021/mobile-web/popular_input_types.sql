#standardSQL
# Popular input types
CREATE TEMPORARY FUNCTION getInputTypes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const almanac = JSON.parse(payload);
    return almanac['input-elements'] && almanac['input-elements'].map(function(node) {
        return node.type.toLowerCase();
    });
  } catch (e) {
    return [];
  }
''';

SELECT
    input_type,
    COUNT(input_type) AS occurences,
    COUNT(DISTINCT url) AS pages,
    total_pages AS total_pages,

    COUNT(input_type) / SUM(COUNT(0)) OVER () AS occurence_perc,
    COUNT(DISTINCT url) / total_pages AS pages_perc
FROM
    `httparchive.pages.2021_07_01_mobile`,
    (SELECT COUNT(0) AS total_pages FROM `httparchive.summary_pages.2021_07_01_mobile`),
    UNNEST(getInputTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) as input_type
GROUP BY
  input_type,
  total_pages
ORDER BY
  occurence DESC
