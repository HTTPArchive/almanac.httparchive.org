#standardSQL
# Popular mobile input types
CREATE TEMPORARY FUNCTION getInputTypes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const almanac = JSON.parse(payload);
    return almanac.input_elements.nodes.map(function(node) {
      return node.type.toLowerCase();
    });
  } catch (e) {
    return [];
  }
''';

SELECT
  total_pages_analyzed,
  SUM(COUNT(0)) OVER () AS total_inputs,

  input_type,
  COUNT(input_type) AS occurences,
  COUNT(DISTINCT url) AS total_pages_used_in,

  COUNT(input_type) / SUM(COUNT(0)) OVER () AS perc_of_all_inputs,
  COUNT(DISTINCT url) / total_pages_analyzed AS perc_used_in_pages
FROM
  `httparchive.pages.2020_08_01_mobile`,
  (SELECT COUNT(0) AS total_pages_analyzed FROM `httparchive.pages.2020_08_01_mobile`),
  UNNEST(getInputTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) as input_type
GROUP BY
  input_type,
  total_pages_analyzed
ORDER BY
  occurences DESC
