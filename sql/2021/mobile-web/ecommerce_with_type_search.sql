#standardSQL
# Ecommerce pages using type=search inputs
CREATE TEMPORARY FUNCTION getSearchInputStats(payload STRING)
RETURNS STRUCT<has_inputs BOOLEAN, has_search_inputs BOOLEAN> LANGUAGE js AS '''
  try {
    const almanac = JSON.parse(payload);
    const search_node_index = almanac.input_elements.nodes.findIndex((node) => {
      return node.type.toLowerCase() === 'search';
    });

    return {
      has_inputs: almanac.input_elements.total > 0,
      has_search_inputs: search_node_index >= 0,
    };
  } catch (e) {
    return {
      has_inputs: false,
      has_search_inputs: false,
    };
  }
''';

SELECT
  client,
  COUNT(0) AS total_pages,
  COUNTIF(search_input_stats.has_inputs) AS pages_with_inputs,
  COUNTIF(search_input_stats.has_search_inputs) AS pages_with_search_inputs,

  COUNTIF(search_input_stats.has_search_inputs) / COUNT(0) AS pct_pages_with_search_inputs,
  COUNTIF(search_input_stats.has_search_inputs) / COUNTIF(search_input_stats.has_inputs) AS pct_input_pages_with_search_inputs
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    getSearchInputStats(JSON_EXTRACT_SCALAR(payload, '$._almanac')) AS search_input_stats,
    url
  FROM
    `httparchive.pages.2021_07_01_*`
)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    category = 'Ecommerce'
)
USING (client, url)
GROUP BY
  client
