-- standardSQL
-- Web Almanac — Button accessible-name sources (sampled), by client (2025-07-01)
--
-- What this does
--   • Extracts source of the accessible name for buttons/submit inputs from a11y tree
--   • Returns, per client:
--       - total_buttons (sum across rows)
--       - total_with_this_source (per source)
--       - perc_of_all_buttons_ratio  (0–1, numeric)
--       - perc_of_all_buttons        (formatted string, e.g., "59.1%")
--
-- Notes
--   • Uses TABLESAMPLE for cost control (tweak %).
--   • WINDOW SUM over client to compute share per client.
--   • Force FLOAT math to avoid integer division.
--   • Provide a formatted percent string to avoid spreadsheet re-scaling surprises.
--
CREATE TEMPORARY FUNCTION a11yButtonNameSources(a11y_json STRING)
RETURNS ARRAY<STRING> LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(a11y_json || '{}');
    const out = [];
    const tree = Array.isArray(a11y.form_control_a11y_tree) ? a11y.form_control_a11y_tree : [];

    for (const node of tree) {
      const isButton = node?.type === "button";
      const isSubmit = node?.type === "input" && node?.attributes?.type === "submit";
      if (!isButton && !isSubmit) continue;

      const name = node?.accessible_name || "";
      const srcs = Array.isArray(node?.accessible_name_sources) ? node.accessible_name_sources : [];

      if (!name || name.length === 0) {
        out.push("No accessible name");
        continue;
      }
      if (srcs.length === 0) continue;

      const s = srcs[0] || {};
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
''';

WITH btn_rows AS (
  SELECT
    client,
    src AS button_name_source
  FROM
    `httparchive.crawl.pages`,
    UNNEST(
      a11yButtonNameSources(
        COALESCE(
          TO_JSON_STRING(custom_metrics.a11y),           -- preferred (JSON column -> STRING)
          JSON_EXTRACT_SCALAR(payload, '$._a11y')        -- legacy fallback
        )
      )
    ) AS src
  WHERE date = '2025-07-01'
)
SELECT
  client,
  -- Totals per client (windowed)
  SUM(COUNT(*)) OVER (PARTITION BY client)         AS total_buttons,
  button_name_source,
  COUNT(*)                                         AS total_with_this_source,

  -- Ratios (0–1) and a printable percent string
  SAFE_DIVIDE(
    CAST(COUNT(*) AS FLOAT64),
    CAST(SUM(COUNT(*)) OVER (PARTITION BY client) AS FLOAT64)
  )                                                AS perc_of_all_buttons_ratio,
  FORMAT('%.1f%%',
    100 * SAFE_DIVIDE(
            CAST(COUNT(*) AS FLOAT64),
            CAST(SUM(COUNT(*)) OVER (PARTITION BY client) AS FLOAT64)
          )
  )                                                AS perc_of_all_buttons
FROM btn_rows
GROUP BY client, button_name_source
ORDER BY client, perc_of_all_buttons_ratio DESC, button_name_source;
