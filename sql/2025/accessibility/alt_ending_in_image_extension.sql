-- UDF must come before any WITH/SELECT
CREATE TEMPORARY FUNCTION getUsedExtensions(payload STRING)
RETURNS ARRAY<STRUCT<extension STRING, total INT64>>
LANGUAGE js AS r'''
try {
  if (!payload) return [];
  const a11y = JSON.parse(payload);
  const fe = a11y && a11y.file_extension_alts && a11y.file_extension_alts.file_extensions;
  if (!fe || typeof fe !== 'object') return [];
  return Object.entries(fe).map(([extension, total]) => ({
    extension,
    total: Number(total) || 0
  }));
} catch (e) { return []; }
''';

#standardSQL
# Purpose
#   Quantify how often <img> alt text ends with an image file extension
#   (e.g., “.jpg”, “.png”) for a single crawl date, split by client and is_root_page.
#
# Outputs (per client, is_root_page, extension)
#   • sites_with_non_empty_alt           – sites (distinct pages) with ≥1 non-empty alt
#   • sites_with_file_extension_alt      – sites with ≥1 alt ending in a file extension
#   • total_alts_with_file_extensions    – total alts that end in a file extension
#   • pct_sites_with_file_extension_alt  – string percentage of sites with file-extension alt
#   • pct_alts_with_file_extension       – string percentage of alts ending with any extension
#   • extension                          – specific file extension (e.g., "jpg")
#   • total_sites_using                  – sites with ≥1 alt ending in this extension
#   • pct_applicable_sites_using         – string percentage of sites with non-empty alts using this extension
#   • total_occurrences                  – total occurrences of this extension in alt text
#   • pct_total_occurrences              – string percentage of extension occurrences among all file-extension alts
#
# Notes
#   • Percentages are returned as formatted strings (e.g. "6.7%") to match 2024 output style.
#   • Underlying math uses SAFE_DIVIDE to avoid divide-by-zero.
#   • Cost-saving sampler included; remove cfg CTE and predicates or set enable_sample=FALSE for full run.
#
WITH
  params AS (SELECT DATE '2025-07-01' AS crawl_date),

  cfg AS (
    SELECT
      TRUE  AS enable_sample,   -- set FALSE (or delete cfg + predicates) for full run
      10000 AS modulus,         -- larger modulus => smaller sample (~0.01% here)
      0     AS remainder
  ),

  base_pages AS (
    SELECT
      p.client,
      p.is_root_page,
      p.page,
      p.custom_metrics.a11y   AS a11y,
      p.custom_metrics.markup AS markup
    FROM `httparchive.crawl.pages` AS p
    JOIN params ON p.date = params.crawl_date
    CROSS JOIN cfg
    WHERE
      NOT cfg.enable_sample
      OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder
  ),

  site_rollup AS (
    SELECT
      bp.client,
      bp.is_root_page,
      COUNTIF(total_non_empty_alt > 0) AS sites_with_non_empty_alt,
      COUNTIF(total_with_file_extension > 0) AS sites_with_file_extension_alt,
      SUM(total_non_empty_alt)               AS total_non_empty_alts,
      SUM(total_with_file_extension)         AS total_alts_with_file_extensions
    FROM (
      SELECT
        bp.client,
        bp.is_root_page,
        SAFE_CAST(JSON_VALUE(bp.markup, '$.images.img.alt.present') AS INT64) AS total_non_empty_alt,
        SAFE_CAST(JSON_VALUE(bp.a11y,  '$.file_extension_alts.total_with_file_extension') AS INT64) AS total_with_file_extension
      FROM base_pages AS bp
    ) bp
    GROUP BY bp.client, bp.is_root_page
  )

SELECT
  bp.client,
  bp.is_root_page,
  sr.sites_with_non_empty_alt,
  sr.sites_with_file_extension_alt,
  sr.total_alts_with_file_extensions,

  -- Percentages as strings
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(sr.sites_with_file_extension_alt, sr.sites_with_non_empty_alt))
    AS pct_sites_with_file_extension_alt,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(sr.total_alts_with_file_extensions, sr.total_non_empty_alts))
    AS pct_alts_with_file_extension,

  ext.extension,

  COUNT(DISTINCT bp.page) AS total_sites_using,

  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(COUNT(DISTINCT bp.page), sr.sites_with_non_empty_alt))
    AS pct_applicable_sites_using,

  SUM(ext.total) AS total_occurrences,

  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(SUM(ext.total), sr.total_alts_with_file_extensions))
    AS pct_total_occurrences

FROM base_pages AS bp
CROSS JOIN UNNEST(getUsedExtensions(TO_JSON_STRING(bp.a11y))) AS ext
LEFT JOIN site_rollup sr
  ON sr.client = bp.client AND sr.is_root_page = bp.is_root_page

GROUP BY
  bp.client,
  bp.is_root_page,
  sr.sites_with_non_empty_alt,
  sr.sites_with_file_extension_alt,
  sr.total_alts_with_file_extensions,
  sr.total_non_empty_alts,
  ext.extension

ORDER BY
  bp.client,
  bp.is_root_page,
  total_occurrences DESC;
