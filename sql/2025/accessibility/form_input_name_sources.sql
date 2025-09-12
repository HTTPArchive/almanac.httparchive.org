-- standardSQL
-- Web Almanac — A11Y name sources for <input>
--
-- What this does (generic, applies to both sample and live):
--   • Prefer 2025 JSON: custom_metrics.a11y or custom_metrics.other.a11y (both JSON-typed)
--   • Fallback to legacy: payload._a11y
--   • For each page, walk form_control_a11y_tree and collect a “pretty” source
--       - Skip <button> and <input type="submit">
--       - If accessible_name is empty → "No accessible name"
--       - First source pretty-printed as:
--           "attribute: {attr}" | "relatedElement: {attr|label}" | "{type}"
--   • Output per {client, is_root_page} to mirror the 2024 structure:
--       client, is_root_page, total_inputs, input_name_source, total_with_this_source, perc_of_all_inputs

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
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
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
  SUM(COUNT(*)) OVER (PARTITION BY client) AS total_inputs,
  input_name_source,
  COUNT(*) AS total_with_this_source,
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNT(*),
                           SUM(COUNT(*)) OVER (PARTITION BY client))) AS perc_of_all_inputs
FROM per_input
GROUP BY client, is_root_page, input_name_source
ORDER BY client, is_root_page, total_with_this_source DESC;
