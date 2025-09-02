#standardSQL
# Where input elements get their A11Y names from
CREATE TEMPORARY FUNCTION a11yInputNameSources(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(payload);

    const accessible_name_sources = [];
    for (const tree_node of a11y.form_control_a11y_tree) {
      if (tree_node.type === "button") {
        continue;
      }
      if (tree_node.type === "input" && tree_node.attributes.type === "submit") {
        continue;
      }

      if (tree_node.accessible_name.length === 0) {
        // No A11Y name given
        accessible_name_sources.push("No accessible name");
        continue;
      }

      if (tree_node.accessible_name_sources.length <= 0) {
        continue;
      }

      const name_source = tree_node.accessible_name_sources[0];
      let pretty_name_source = name_source.type;
      if (name_source.type === "attribute") {
        pretty_name_source = `${name_source.type}: ${name_source.attribute}`;
      } else if (name_source.type === "relatedElement") {
        if (name_source.attribute) {
          pretty_name_source = `${name_source.type}: ${name_source.attribute}`;
        } else {
          pretty_name_source = `${name_source.type}: label`;
        }
      }

      accessible_name_sources.push(pretty_name_source);
    }

    return accessible_name_sources;
  } catch (e) {
    return [];
  }
''';

SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_inputs,
  input_name_source,
  COUNT(0) AS total_with_this_source,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS perc_of_all_inputs
FROM (
  SELECT
    client,
    is_root_page,
    input_name_source
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      a11yInputNameSources(JSON_EXTRACT_SCALAR(payload, '$._a11y'))
    ) AS input_name_source
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page,
  input_name_source;
