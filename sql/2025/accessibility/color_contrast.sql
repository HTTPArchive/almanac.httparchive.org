-- standardSQL
-- Web Almanac — % of PAGES with sufficient text color contrast (Lighthouse)
--
-- Metric definition
--   A page is counted “good contrast” when Lighthouse reports:
--     lighthouse.audits['color-contrast'].score == 1
--   “Applicable” pages are those where the audit returned a non-NULL score.
--
-- Outputs (page-level, not site-level)
--   client, is_root_page, date
--   total_applicable            = pages with a non-NULL score
--   total_good_contrast         = pages with score == 1
--   perc_good_contrast_num      = numeric ratio in [0,1] (safe-divided)
--   perc_good_contrast          = formatted percentage string (e.g., "83.4%")
--
-- Notes
--   • SAFE_CAST + JSON_VALUE handle occasional non-numeric/NULL values.
--   • SAFE_DIVIDE prevents division-by-zero when no pages are applicable.
--
WITH per_page AS (
  SELECT
    client,
    is_root_page,
    date,
    -- Extract Lighthouse color-contrast score (string -> NUMERIC)
    SAFE_CAST(JSON_VALUE(lighthouse, '$.audits.color-contrast.score') AS NUMERIC) AS color_contrast_score
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)
SELECT
  client,
  is_root_page,
  date,

  COUNTIF(color_contrast_score IS NOT NULL)                           AS total_applicable,
  COUNTIF(color_contrast_score = 1)                                   AS total_good_contrast,

  -- Numeric ratio (0..1) and human-readable formatted percent
  SAFE_DIVIDE(COUNTIF(color_contrast_score = 1),
              COUNTIF(color_contrast_score IS NOT NULL))              AS perc_good_contrast_num,
  FORMAT('%.1f%%',
         100 * SAFE_DIVIDE(COUNTIF(color_contrast_score = 1),
                           COUNTIF(color_contrast_score IS NOT NULL))) AS perc_good_contrast
FROM per_page
GROUP BY client, is_root_page, date
ORDER BY client, is_root_page;
