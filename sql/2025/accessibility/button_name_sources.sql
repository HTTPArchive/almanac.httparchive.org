-- standardSQL
-- Web Almanac — Where <button> accessible names come from (2025)
--
-- What this does
--   • Parses the a11y tree (custom_metrics.a11y.form_control_a11y_tree) via a JS UDF.
--   • Emits a label per button-like control indicating the first accessible-name “source”:
--       - "attribute: aria-label", "attribute: title", "relatedElement: label", etc.
--       - "No accessible name" when the control has an empty accessible_name.
--   • Aggregates by client (desktop/mobile) for root pages only, and shows
--     counts and share per source.
--
-- Key notes
--   • Data location (2025): use custom_metrics.a11y (JSON). The legacy payload._a11y path is empty here.
--   • The UDF expects a STRING, so we pass TO_JSON_STRING(custom_metrics.a11y).
--   • TABLESAMPLE retained for speed; adjust percentage as needed.
--   • Window totals are computed in an outer SELECT for clarity.
--
CREATE TEMPORARY FUNCTION a11yButtonNameSources(a11y_json STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS '''
  try {
    if (!a11y_json) return [];
    const a11y = JSON.parse(a11y_json);

    const tree = Array.isArray(a11y.form_control_a11y_tree)
      ? a11y.form_control_a11y_tree
      : [];

    const out = [];
    for (const node of tree) {
      const type = node && node.type;
      const attrs = (node && node.attributes) || {};

      // Consider <button>, and <input type="submit">
      const isButton = type === "button";
      const isSubmitInput = (type === "input") && (attrs.type === "submit");
      if (!isButton && !isSubmitInput) continue;

      const accName = (node.accessible_name || "");
      const sources = Array.isArray(node.accessible_name_sources)
        ? node.accessible_name_sources
        : [];

      if (!accName || accName.length === 0) {
        out.push("No accessible name");
        continue;
      }

      if (sources.length === 0) continue;

      const src = sources[0] || {};
      let pretty = src.type || "unknown";

      if (src.type === "attribute") {
        pretty = `attribute: ${src.attribute || "unknown"}`;
      } else if (src.type === "relatedElement") {
        // If attribute (e.g., "aria-labelledby") present, keep it;
        // otherwise call it "label".
        pretty = `relatedElement: ${src.attribute || "label"}`;
      }

      out.push(pretty);
    }
    return out;
  } catch (e) {
    return [];
  }
''';

WITH exploded AS (
  SELECT
    client,
    -- Keep only root pages
    button_name_source
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      a11yButtonNameSources(TO_JSON_STRING(custom_metrics.a11y))
    ) AS button_name_source
  WHERE
    date = '2025-07-01'
    AND is_root_page
),
by_source AS (
  SELECT
    client,
    button_name_source,
    COUNT(*) AS total_with_this_source
  FROM exploded
  GROUP BY client, button_name_source
)
SELECT
  client,
  -- Total buttons (across all sources) per client
  SUM(total_with_this_source) OVER (PARTITION BY client) AS total_buttons,
  button_name_source,
  total_with_this_source,
  SAFE_DIVIDE(
    total_with_this_source,
    SUM(total_with_this_source) OVER (PARTITION BY client)
  ) AS perc_of_all_buttons
FROM by_source
ORDER BY client, perc_of_all_buttons DESC;
