#standardSQL
# Popular input types
CREATE TEMPORARY FUNCTION getInputTypes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const almanac = JSON.parse(payload);
    return almanac.input_elements && almanac.input_elements.map(function(node) {
      return node.type.toLowerCase();
    });
  } catch (e) {
    return [];
  }
''';

SELECT
  total_sites AS total_sites,
  SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS total_sites_with_inputs,

  input_type,
  COUNT(0) AS total_sites_using,
  COUNT(0) / SUM(COUNT(DISTINCT url)) OVER (PARTITION BY client) AS pct_input_sites_using,
  COUNT(0) / total_sites AS pct_sites
FROM
  `httparchive.pages.2021_07_01_mobile`,
  (SELECT COUNT(0) AS total_sites FROM `httparchive.summary_pages.2021_07_01_mobile`),
  UNNEST(getInputTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) as input_type
GROUP BY
  input_type,
  total_sites
ORDER BY
  occurence DESC
