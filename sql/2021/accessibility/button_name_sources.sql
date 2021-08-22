#standardSQL
# Where button elements get their A11Y names from
CREATE TEMPORARY FUNCTION a11yButtonNameSources(payload STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(payload);

    const accessible_name_sources = [];
    for (const tree_node of a11y.form_control_a11y_tree) {
      const is_button_type = tree_node.type === "button";
      const is_submit_input = tree_node.type === "input" && tree_node.attributes.type === "submit";
      if (!is_button_type && !is_submit_input) {
        continue;
      }

      if (tree_node.accessible_name.length === 0) {
        // No A11Y name given
        accessible_name_sources("No accessible name");
      }

      if (tree_node.accessible_name_sources.length <= 0) {
        continue;
      }

      const name_source = tree_node.accessible_name_sources[0];
      let pretty_name_source = name_source.type;
      if (name_source.type === "attribute") {
        pretty_name_source = `${name_source.type}: ${name_source.attribute}`;
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
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_buttons,

  button_name_source,
  COUNT(0) AS total_with_this_source,
  COUNT(0) / SUM(COUNT(0)) OVER (PARTITION BY client) AS perc_of_all_buttons
FROM (
  SELECT
    _TABLE_SUFFIX AS client,
    button_name_source
  FROM
    `httparchive.pages.2021_07_01_*`,
    UNNEST(
      a11yButtonNameSources(JSON_EXTRACT_SCALAR(payload, '$._a11y'))
    ) AS button_name_source
)
GROUP BY
  client,
  button_name_source
ORDER BY
  perc_of_all_buttons DESC
