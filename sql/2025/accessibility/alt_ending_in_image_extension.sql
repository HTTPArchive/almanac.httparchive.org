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
#   • total_non_empty_alts               – total non-empty alts across those sites
#   • total_alts_with_file_extensions    – total alts that end in a file extension
#   • extension                          – specific file extension (e.g., "jpg")
#   • total_sites_using                  – sites with ≥1 alt ending in this extension
#   • pct_sites_with_file_extension_alt  – share of applicable sites with any file-extension alt
#   • pct_alts_with_file_extension       – share of all non-empty alts that end with any extension
#   • pct_applicable_sites_using         – share of applicable sites using this specific extension
#   • total_occurrences                  – total occurrences of this extension in alt text
#   • pct_total_occurrences              – share of all file-extension alt occurrences that are this extension
#
-- Set the crawl date once here
WITH
  params AS (SELECT DATE '2025-07-01' AS crawl_date),

  -- Cost-saving toggle (remove later for full run)
  cfg AS (
    SELECT
      FALSE  AS enable_sample,   -- set to FALSE (or delete cfg + predicates) for full run
      100000 AS modulus,         -- larger modulus => smaller sample (~0.01% here)
      0     AS remainder
  ),

  -- Sampled base: filter BEFORE any JSON parsing/UNNEST; select only needed subfields
  base_pages AS (
    SELECT
      p.client,
      p.is_root_page,
      p.page,
      p.custom_metrics.a11y   AS a11y,    -- JSON
      p.custom_metrics.markup AS markup   -- JSON
    FROM `httparchive.crawl.pages` AS p
    JOIN params ON p.date = params.crawl_date
    CROSS JOIN cfg
    WHERE
      NOT cfg.enable_sample
      OR MOD(ABS(FARM_FINGERPRINT(p.page)), cfg.modulus) = cfg.remainder
  ),

  -- Denominators and "any extension" numerators, from the SAME sampled base
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

  -- Of sites with a non-empty alt, what % have any alt with a file extension
  SAFE_DIVIDE(sr.sites_with_file_extension_alt, sr.sites_with_non_empty_alt) AS pct_sites_with_file_extension_alt,

  -- Given a random non-empty alt, how often does it end in a file extension
  SAFE_DIVIDE(sr.total_alts_with_file_extensions, sr.total_non_empty_alts)   AS pct_alts_with_file_extension,

  ext.extension AS extension,

  -- Sites using this specific extension at least once (still from the sampled base)
  COUNT(DISTINCT bp.page) AS total_sites_using,

  -- Of applicable sites, what % use this specific extension at least once
  SAFE_DIVIDE(COUNT(DISTINCT bp.page), sr.sites_with_non_empty_alt) AS pct_applicable_sites_using,

  -- Total occurrences of this specific extension in alts
  SUM(ext.total) AS total_occurrences,

  -- Given a random file-extension alt, how often is it this extension
  SAFE_DIVIDE(SUM(ext.total), sr.total_alts_with_file_extensions) AS pct_total_occurrences

FROM base_pages AS bp
CROSS JOIN UNNEST(
  getUsedExtensions(TO_JSON_STRING(bp.a11y))
) AS ext
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
