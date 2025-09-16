-- standardSQL
-- Web Almanac — Required form controls (: input, select, textarea)
--
-- What this does (applies to both sample and live):
--   • Pulls A11Y JSON from 2025 locations (custom_metrics.a11y or custom_metrics.other.a11y), else legacy payload._a11y
--   • JS UDF walks required_form_controls and returns aggregate counters for a page
--   • Aggregates per {client, is_root_page}: totals and percentages (numeric via SAFE_DIVIDE)

CREATE TEMPORARY FUNCTION requiredControls(a11y_str STRING)
RETURNS STRUCT<
  total INT64,
  asterisk INT64,
  required_attribute INT64,
  aria_required INT64,
  all_three INT64,
  asterisk_required INT64,
  asterisk_aria INT64,
  required_with_aria INT64
>
LANGUAGE js AS r"""
try {
  const a11y = JSON.parse(a11y_str || "{}");
  // required_form_controls is expected to be an array; gracefully handle others
  const controls = Array.isArray(a11y.required_form_controls)
      ? a11y.required_form_controls
      : [];

  let total = controls.length;
  let asterisk = 0;
  let required_attribute = 0;
  let aria_required = 0;

  let all_three = 0;
  let asterisk_required = 0;
  let asterisk_aria = 0;
  let required_with_aria = 0;

  for (const c of controls) {
    if (!c || typeof c !== "object") continue;

    const hasAsterisk = !!c.has_visible_required_asterisk;
    const hasRequired = !!c.has_required;
    const hasAriaReq  = !!c.has_aria_required;

    if (hasAsterisk) asterisk++;
    if (hasRequired) required_attribute++;
    if (hasAriaReq)  aria_required++;

    if (hasAsterisk && hasRequired) asterisk_required++;
    if (hasAsterisk && hasAriaReq)  asterisk_aria++;
    if (hasRequired && hasAriaReq)  required_with_aria++;
    if (hasAsterisk && hasRequired && hasAriaReq) all_three++;
  }

  return {
    total,
    asterisk,
    required_attribute,
    aria_required,
    all_three,
    asterisk_required,
    asterisk_aria,
    required_with_aria
  };
} catch (e) {
  return {
    total: 0,
    asterisk: 0,
    required_attribute: 0,
    aria_required: 0,
    all_three: 0,
    asterisk_required: 0,
    asterisk_aria: 0,
    required_with_aria: 0
  };
}
""";

WITH
src_base AS (
  SELECT client, is_root_page, custom_metrics, payload
  FROM `httparchive.crawl.pages`
  WHERE date = DATE '2025-07-01'
),

per_page AS (
  SELECT
    b.client,
    b.is_root_page,
    requiredControls(
      COALESCE(
        TO_JSON_STRING(b.custom_metrics.a11y),
        TO_JSON_STRING(b.custom_metrics.other.a11y),
        TO_JSON_STRING(JSON_QUERY(b.payload, '$._a11y'))
      )
    ) AS stats
  FROM src_base AS b
),

agg AS (
  SELECT
    client,
    is_root_page,
    COUNT(*) AS total_sites,
    COUNTIF(stats.total > 0) AS total_sites_with_required_controls,

    SUM(stats.total)                AS total_required_controls,
    SUM(stats.asterisk)             AS total_asterisk,
    SUM(stats.required_attribute)   AS total_required_attribute,
    SUM(stats.aria_required)        AS total_aria_required,
    SUM(stats.all_three)            AS total_all_three,
    SUM(stats.asterisk_required)    AS total_asterisk_required,
    SUM(stats.asterisk_aria)        AS total_asterisk_aria,
    SUM(stats.required_with_aria)   AS total_required_with_aria
  FROM per_page
  GROUP BY client, is_root_page
)

SELECT
  client,
  is_root_page,
  total_sites,
  total_sites_with_required_controls,
  total_required_controls,

  total_asterisk,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_asterisk, total_required_controls))           AS perc_asterisk,

  total_required_attribute,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_required_attribute, total_required_controls)) AS perc_required_attribute,

  total_aria_required,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_aria_required, total_required_controls))      AS perc_aria_required,

  total_all_three,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_all_three, total_required_controls))          AS perc_all_three,

  total_asterisk_required,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_asterisk_required, total_required_controls))  AS perc_asterisk_required,

  total_asterisk_aria,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_asterisk_aria, total_required_controls))      AS perc_asterisk_aria,

  total_required_with_aria,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(total_required_with_aria, total_required_controls)) AS perc_required_with_aria
FROM agg
ORDER BY client, is_root_page;
