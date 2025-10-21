WITH base_data AS (
  SELECT
    date,
    client,
    is_root_page,
    CAST(JSON_VALUE(summary.bytesTotal) AS INT64) AS bytes_total,
    -- these are page level CrUX metrics, pages may not have all / any metrics available, but do represent the user experience of the measured page weight vs. origin.
    CAST(JSON_VALUE(summary.crux.metrics.largest_contentful_paint.percentiles.p75) AS FLOAT64) / 1000 AS lcp,
    CAST(JSON_VALUE(summary.crux.metrics.cumulative_layout_shift.percentiles.p75) AS FLOAT64) AS cls,
    CAST(JSON_VALUE(summary.crux.metrics.interaction_to_next_paint.percentiles.p75) AS FLOAT64) AS inp,
    CAST(JSON_VALUE(summary.crux.metrics.first_contentful_paint.percentiles.p75) AS FLOAT64) / 1000 AS fcp,
    CAST(JSON_VALUE(summary.crux.metrics.experimental_time_to_first_byte.percentiles.p75) AS FLOAT64) AS ttfb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
),

categorised_data AS (
  SELECT
    date,
    client,
    is_root_page,
    bytes_total,
    CASE
      WHEN bytes_total <= 1024.0 * 1024.0 * 1 THEN '0mb-1mb'
      WHEN bytes_total > 1024.0 * 1024.0 * 1 AND bytes_total <= 1024.0 * 1024.0 * 2 THEN '1mb-2mb'
      WHEN bytes_total > 1024.0 * 1024.0 * 2 AND bytes_total <= 1024.0 * 1024.0 * 3 THEN '2mb-3mb'
      WHEN bytes_total > 1024.0 * 1024.0 * 3 AND bytes_total <= 1024.0 * 1024.0 * 4 THEN '3mb-4mb'
      WHEN bytes_total > 1024.0 * 1024.0 * 4 AND bytes_total <= 1024.0 * 1024.0 * 5 THEN '4mb-5mb'
      WHEN bytes_total > 1024.0 * 1024.0 * 5 THEN '>5mb'
      ELSE NULL
    END AS category,
    -- these are page level CrUX metrics, pages may not have all / any metrics available, but do represent the user experience of the measured page weight vs. origin.
    CASE
      -- Check LCP and CLS exist and pass, and INP passes if it's not NULL (INP is optional)
      WHEN IFNULL(lcp, 999) <= 2.5 AND IFNULL(cls, 999) <= 0.1 AND IFNULL(inp, 0) <= 200 THEN TRUE
      ELSE FALSE
    END AS passes_cwv,
    CASE
      -- Check LCP and CLS exist
      WHEN lcp IS NOT NULL AND cls IS NOT NULL THEN TRUE
      ELSE FALSE
    END AS has_cwv
  FROM
    base_data
)

SELECT
  client,
  is_root_page,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND passes_cwv), COUNTIF(category = '0mb-1mb' AND has_cwv)), 4) AS pass_all_cwv_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND passes_cwv), COUNTIF(category = '1mb-2mb' AND has_cwv)), 4) AS pass_all_cwv_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND passes_cwv), COUNTIF(category = '2mb-3mb' AND has_cwv)), 4) AS pass_all_cwv_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND passes_cwv), COUNTIF(category = '3mb-4mb' AND has_cwv)), 4) AS pass_all_cwv_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND passes_cwv), COUNTIF(category = '4mb-5mb' AND has_cwv)), 4) AS pass_all_cwv_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND passes_cwv), COUNTIF(category = '>5mb' AND has_cwv)), 4) AS pass_all_cwv_pct_5mb_and_above
FROM
  categorised_data
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
