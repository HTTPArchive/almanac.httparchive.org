-- standardSQL
-- Web Almanac — IMG ALT coverage from 2025 schema (markup.images)
--
-- What this query does
--   • Uses the 2025+ path: custom_metrics.markup.images
--       Structure (example):
--         {
--           "img": {
--             "total": <n>,
--             "src_total": <n>,
--             "srcset_total": <n>,
--             "alt": { "present": <n>, "blank": <n>, "missing": <n> },
--             "loading": { ... },
--             "dimensions": { ... }
--           },
--           "picture": { "total": <n> },
--           "source":  { "total": <n>, ... }
--         }
--   • Extracts, per page: img.total, img.alt.present, img.alt.blank, img.alt.missing.
--   • Aggregates by {client, is_root_page}.
--   • Reports:
--       - pages_sampled
--       - pages_with_any_img
--       - images_total
--       - alt_present / alt_blank / alt_missing
--       - pct_alt_present_of_images, pct_alt_blank_of_images, pct_alt_missing_of_images
--       - pct_pages_with_all_alts_present (pages where img.total > 0 and alt.missing = 0)
--
WITH sampled_pages AS (
  SELECT
    client,
    is_root_page,
    page,
    custom_metrics.markup AS markup_json
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
    AND custom_metrics.markup IS NOT NULL

    -- ===== Deterministic sampling (~0.1%) =====
    -- AND MOD(ABS(FARM_FINGERPRINT(page)), 1000) = 0
    -- For a different rate, change 1000 (see header). For full run, remove this line.
),
per_page AS (
  SELECT
    client,
    is_root_page,

    -- Extract counts from JSON; JSON_VALUE returns STRING → cast to INT64 safely
    SAFE_CAST(JSON_VALUE(markup_json, '$.images.img.total')          AS INT64) AS img_total,
    SAFE_CAST(JSON_VALUE(markup_json, '$.images.img.alt.present')    AS INT64) AS alt_present,
    SAFE_CAST(JSON_VALUE(markup_json, '$.images.img.alt.blank')      AS INT64) AS alt_blank,
    SAFE_CAST(JSON_VALUE(markup_json, '$.images.img.alt.missing')    AS INT64) AS alt_missing
  FROM sampled_pages
),
agg AS (
  SELECT
    client,
    is_root_page,
    COUNT(*)                                                AS pages_sampled,
    COUNTIF(IFNULL(img_total, 0) > 0)                       AS pages_with_any_img,

    -- Sums across sampled pages
    SUM(IFNULL(img_total,   0))                             AS images_total,
    SUM(IFNULL(alt_present, 0))                             AS alt_present_total,
    SUM(IFNULL(alt_blank,   0))                             AS alt_blank_total,
    SUM(IFNULL(alt_missing, 0))                             AS alt_missing_total,

    -- Page-level condition: all images have some alt (no "missing")
    COUNTIF(IFNULL(img_total, 0) > 0 AND IFNULL(alt_missing, 0) = 0)
                                                           AS pages_with_all_alts_present
  FROM per_page
  GROUP BY client, is_root_page
)
SELECT
  client,
  is_root_page,
  pages_sampled,
  pages_with_any_img,
  images_total,
  alt_present_total,
  alt_blank_total,
  alt_missing_total,

  -- Percentages (human readable)
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(alt_present_total, images_total)) AS pct_alt_present_of_images,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(alt_blank_total,   images_total)) AS pct_alt_blank_of_images,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(alt_missing_total, images_total)) AS pct_alt_missing_of_images,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(pages_with_any_img, pages_sampled)) AS pct_pages_with_any_img,
  FORMAT('%.1f%%', 100 * SAFE_DIVIDE(pages_with_all_alts_present, NULLIF(pages_with_any_img, 0)))
    AS pct_pages_with_all_alts_present
FROM agg
ORDER BY client, is_root_page;
