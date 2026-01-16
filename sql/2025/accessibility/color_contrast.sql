#standardSQL
-- Color Contrast Audit Results (2025-07-01)
-- Google Sheet: color_contrast
--
-- Purpose
--   • Measure how often pages pass Lighthouse’s "color-contrast" audit.
--   • Report counts and percentages of elements with good contrast, by client
--     (desktop vs mobile) and root-page status.
--
-- Dataset
--   • Source: `httparchive.crawl.pages`
--   • Field: lighthouse → audits.color-contrast.score
--   • Date: 2025-07-01
--
-- Method
--   1. Extract the color-contrast audit score from Lighthouse JSON.
--   2. For each {client, is_root_page}:
--        – total_applicable = pages with a non-null score
--        – total_good_contrast = pages with score = 1 (pass)
--        – perc_good_contrast = share of applicable pages that pass
--
-- Output
--   client             — "desktop" | "mobile"
--   is_root_page       — TRUE if page is a root URL
--   total_applicable   — number of pages with color-contrast audit run
--   total_good_contrast — number of pages passing color-contrast audit
--   perc_good_contrast — fraction of applicable pages with passing scores
SELECT
  client,
  is_root_page,
  COUNTIF(color_contrast_score IS NOT NULL) AS total_applicable,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) AS total_good_contrast,
  COUNTIF(CAST(color_contrast_score AS NUMERIC) = 1) / COUNTIF(color_contrast_score IS NOT NULL) AS perc_good_contrast
FROM (
  SELECT
    client,
    is_root_page,
    date,
    JSON_VALUE(lighthouse, '$.audits.color-contrast.score') AS color_contrast_score
  FROM
    `httparchive.crawl.pages`
    -- TABLESAMPLE SYSTEM (0.1 PERCENT)
  WHERE
    date = '2025-07-01'
)
GROUP BY
  client,
  is_root_page,
  date
ORDER BY
  client,
  is_root_page;
