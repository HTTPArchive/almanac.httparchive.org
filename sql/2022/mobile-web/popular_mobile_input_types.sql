#standardSQL
# Popular mobile input types
CREATE TEMPORARY FUNCTION getInputTypes(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
try {
  const almanac = JSON.parse(payload);
  return almanac.input_elements.nodes.map(function(node) {
    if (!node.type) {
      return "n/a";
    }

    return node.type.toLowerCase();
  });
} catch (e) {
  return [];
}
''';

SELECT
  total_pages_with_inputs,
  total_inputs,

  input_type,
  COUNT(input_type) AS occurences,
  COUNT(DISTINCT url) AS total_pages_used_in,

  COUNT(input_type) / total_inputs AS pct_of_all_inputs,
  COUNT(DISTINCT url) / total_pages_with_inputs AS pct_used_in_pages
FROM
  `httparchive.pages.2022_06_01_mobile`, (
  SELECT
    COUNT(0) AS total_pages_with_inputs
  FROM
    `httparchive.pages.2022_06_01_mobile`
  WHERE
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.input_elements.total') AS INT64) > 0
), (
  SELECT
    SUM(SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.input_elements.total') AS INT64)) AS total_inputs
  FROM
    `httparchive.pages.2022_06_01_mobile`
),
  UNNEST(getInputTypes(JSON_EXTRACT_SCALAR(payload, '$._almanac'))) AS input_type
GROUP BY
  input_type,
  total_inputs,
  total_pages_with_inputs
ORDER BY
  occurences DESC
