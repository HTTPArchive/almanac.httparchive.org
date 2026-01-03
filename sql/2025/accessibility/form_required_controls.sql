-- standardSQL
-- Web Almanac — Required form controls (input, select, textarea) (2025-07-01)
-- Google Spreadsheet: form_required_controls
--
-- Purpose
--   • Measure how required form controls are indicated across sites.
--   • Detect use of visible asterisks, HTML `required` attribute, and `aria-required`.
--   • Count overlaps: controls marked with two or all three methods.
--
-- Method
--   1. UDF `requiredControls` parses JSON for each page’s form controls.
--   2. Pulls from 2025 schema: `custom_metrics.a11y` → `custom_metrics.other.a11y` → legacy `payload._a11y`.
--   3. Inner SELECT: compute per-page stats.
--   4. Outer SELECT: aggregate per {client, is_root_page}, reporting totals and fractions.
--
-- Output columns
--   total_sites                     — pages in group
--   total_sites_with_required_controls — pages with ≥1 required control
--   total_required_controls         — total count of required controls
--   total_asterisk / perc_asterisk  — controls with visible asterisk
--   total_required_attribute / perc_required_attribute — controls with HTML `required`
--   total_aria_required / perc_aria_required — controls with `aria-required`
--   total_all_three / perc_all_three — controls with all three indicators
--   total_asterisk_required / perc_asterisk_required — controls with asterisk+required
--   total_asterisk_aria / perc_asterisk_aria — controls with asterisk+aria-required
--   total_required_with_aria / perc_required_with_aria — controls with required+aria-required
--
-- Notes
--   • Structure mirrors 2024 query for comparability.
--   • Uses SAFE_DIVIDE to avoid division-by-zero errors.
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
LANGUAGE js AS '''
  try {
    const a11y = JSON.parse(a11y_str || "{}");
    const required_form_controls = Array.isArray(a11y.required_form_controls)
      ? a11y.required_form_controls : [];

    const total = required_form_controls.length;
    let asterisk = 0, required_attribute = 0, aria_required = 0;
    let all_three = 0, asterisk_required = 0, asterisk_aria = 0, required_with_aria = 0;

    for (const c of required_form_controls) {
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

    return { total, asterisk, required_attribute, aria_required,
              all_three, asterisk_required, asterisk_aria, required_with_aria };
  } catch (e) {
    return { total:0, asterisk:0, required_attribute:0, aria_required:0,
              all_three:0, asterisk_required:0, asterisk_aria:0, required_with_aria:0 };
  }
''';

SELECT
  client,
  is_root_page,
  COUNT(0) AS total_sites,
  COUNTIF(stats.total > 0) AS total_sites_with_required_controls,
  SUM(stats.total) AS total_required_controls,

  SUM(stats.asterisk) AS total_asterisk,
  SAFE_DIVIDE(SUM(stats.asterisk), SUM(stats.total)) AS perc_asterisk,

  SUM(stats.required_attribute) AS total_required_attribute,
  SAFE_DIVIDE(SUM(stats.required_attribute), SUM(stats.total)) AS perc_required_attribute,

  SUM(stats.aria_required) AS total_aria_required,
  SAFE_DIVIDE(SUM(stats.aria_required), SUM(stats.total)) AS perc_aria_required,

  SUM(stats.all_three) AS total_all_three,
  SAFE_DIVIDE(SUM(stats.all_three), SUM(stats.total)) AS perc_all_three,

  SUM(stats.asterisk_required) AS total_asterisk_required,
  SAFE_DIVIDE(SUM(stats.asterisk_required), SUM(stats.total)) AS perc_asterisk_required,

  SUM(stats.asterisk_aria) AS total_asterisk_aria,
  SAFE_DIVIDE(SUM(stats.asterisk_aria), SUM(stats.total)) AS perc_asterisk_aria,

  SUM(stats.required_with_aria) AS total_required_with_aria,
  SAFE_DIVIDE(SUM(stats.required_with_aria), SUM(stats.total)) AS perc_required_with_aria
FROM (
  SELECT
    client,
    is_root_page,
    requiredControls(
      COALESCE(
        TO_JSON_STRING(custom_metrics.a11y),
        TO_JSON_STRING(custom_metrics.other.a11y),
        TO_JSON_STRING(JSON_QUERY(payload, '$._a11y'))  -- legacy fallback
      )
    ) AS stats
  FROM
    `httparchive.crawl.pages`
  --  `httparchive.sample_data.pages_10k`
  WHERE date = DATE '2025-07-01' -- Comment if `httparchive.sample_data.pages_10k`
) per_page
GROUP BY
  client, is_root_page;
