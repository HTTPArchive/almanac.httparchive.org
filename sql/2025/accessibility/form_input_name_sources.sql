-- standardSQL
-- Web Almanac — A11Y name sources for <input> (2025-07-01)
-- Google Sheets: form_input_name_sources
--
-- Purpose
--   • Identify where <input> elements get their accessible names from.
--   • Excludes <button> and <input type="submit"> for consistency.
--
-- Method
--   1. UDF parses form_control_a11y_tree JSON for each page.
--   2. For each input:
--        - "No accessible name" if accessible_name is empty
--        - Otherwise, first source pretty-printed as:
--            "attribute: {attr}", "relatedElement: {attr|label}", or "{type}"
--   3. Data pulled from custom_metrics.a11y (2025 schema) with fallbacks to
--      custom_metrics.other.a11y or payload._a11y for legacy.
--   4. Aggregate per {client, is_root_page}:
--        - total_inputs (per client)
--        - input_name_source
--        - total_with_this_source
--        - perc_of_all_inputs (share of inputs by source)
CREATE TEMPORARY FUNCTION a11yInputNameSources(a11y_str STRING)
RETURNS ARRAY<STRING>
LANGUAGE js AS r"""
try {
  const a11y = JSON.parse(a11y_str || "{}");
  const tree = Array.isArray(a11y.form_control_a11y_tree) ? a11y.form_control_a11y_tree : [];
  const out = [];

  for (const node of tree) {
    if (!node || typeof node !== "object") continue;

    const t = node.type || "";
    if (t === "button") continue;
    if (t === "input" && node.attributes && node.attributes.type === "submit") continue;

    const name = (node.accessible_name ?? "");
    const sources = Array.isArray(node.accessible_name_sources) ? node.accessible_name_sources : [];

    if (!String(name).length) {
      out.push("No accessible name");
      continue;
    }
    if (!sources.length) continue;

    const s = sources[0] || {};
    let pretty = s.type || "unknown";
    if (s.type === "attribute") {
      pretty = `attribute: ${s.attribute || "unknown"}`;
    } else if (s.type === "relatedElement") {
      pretty = `relatedElement: ${s.attribute || "label"}`;
    }
    out.push(pretty);
  }
  return out;
} catch (e) {
  return [];
}
""";

WITH
src_base AS (
  SELECT client, is_root_page, custom_metrics, payload
  FROM
    `httparchive.crawl.pages`
    -- `httparchive.sample_data.pages_10k`
  WHERE date = DATE '2025-07-01' -- Comment out if used `httparchive.sample_data.pages_10k`
),

src AS (
  SELECT
    b.client,
    b.is_root_page,
    COALESCE(
      TO_JSON_STRING(b.custom_metrics.a11y),
      TO_JSON_STRING(b.custom_metrics.other.a11y),
      TO_JSON_STRING(JSON_QUERY(b.payload, '$._a11y'))
    ) AS a11y_str
  FROM src_base AS b
  WHERE b.custom_metrics IS NOT NULL
),

per_input AS (
  SELECT
    client,
    is_root_page,
    src_txt AS input_name_source
  FROM src,
    UNNEST(a11yInputNameSources(a11y_str)) AS src_txt
  WHERE a11y_str IS NOT NULL
)

SELECT
  client,
  is_root_page,
  SUM(COUNT(0)) OVER (PARTITION BY client) AS total_inputs,
  input_name_source,
  COUNT(0) AS total_with_this_source,
  SAFE_DIVIDE(COUNT(0), SUM(COUNT(0)) OVER (PARTITION BY client)) AS perc_of_all_inputs
FROM per_input
GROUP BY client, is_root_page, input_name_source
ORDER BY client, is_root_page, total_with_this_source DESC;
