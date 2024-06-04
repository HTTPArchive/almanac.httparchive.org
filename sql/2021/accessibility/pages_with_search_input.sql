#standardSQL
# Pages with search input
CREATE TEMPORARY FUNCTION hasSearchInput(payload STRING)
RETURNS BOOLEAN LANGUAGE js AS '''
  try {
    const almanac = JSON.parse(payload);
    return almanac.input_elements.nodes.some((node) => {
      if (node.type.toLowerCase() === "search") {
        return true;
      }

      // Detect regular inputs of type text and the first word being "search"
      if (node.type.toLowerCase() === "text" &&
          /^\\s*search(\\s|$)/i.test(node.placeholder || '')) {
        return true;
      }

      return false;
    });

  } catch (e) {
    return false;
  }
''';

SELECT
  client,
  COUNT(0) AS total_sites,
  COUNTIF(has_inputs) AS total_with_inputs,
  COUNTIF(has_search_input) AS total_with_search_input,

  # Perc of all sites which have a search input
  COUNTIF(has_search_input) / COUNT(0) AS perc_sites_with_search_input,
  # Of sites that have at least 1 input element, how many have a search input
  COUNTIF(has_search_input) / COUNTIF(has_inputs) AS perc_input_sites_with_search_input
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    SAFE_CAST(JSON_EXTRACT_SCALAR(JSON_EXTRACT_SCALAR(payload, '$._almanac'), '$.input_elements.total') AS INT64) > 0 AS has_inputs,
    hasSearchInput(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS has_search_input
  FROM
    `httparchive.pages.2021_07_01_*`
)
GROUP BY
  client
