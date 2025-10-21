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
      WHEN lcp <= 2.5 THEN 'good'
      WHEN lcp > 2.5 AND lcp <= 4.0 THEN 'ni'
      WHEN lcp > 4.0 THEN 'poor'
      ELSE NULL
    END AS lcp_category,
    CASE
      WHEN cls <= 0.1 THEN 'good'
      WHEN cls > 0.1 AND cls <= 0.25 THEN 'ni'
      WHEN cls > 0.25 THEN 'poor'
      ELSE NULL
    END AS cls_category,
    CASE
      WHEN inp <= 200 THEN 'good'
      WHEN inp > 200 AND inp <= 500 THEN 'ni'
      WHEN inp > 500 THEN 'poor'
      ELSE NULL
    END AS inp_category,
    CASE
      WHEN fcp <= 1.8 THEN 'good'
      WHEN fcp > 1.8 AND fcp <= 3.0 THEN 'ni'
      WHEN fcp > 3.0 THEN 'poor'
      ELSE NULL
    END AS fcp_category,
    CASE
      WHEN ttfb <= 800 THEN 'good'
      WHEN ttfb > 800 AND ttfb <= 1800 THEN 'ni'
      WHEN ttfb > 1800 THEN 'poor'
      ELSE NULL
    END AS ttfb_category
  FROM
    base_data
)

SELECT
  client,
  is_root_page,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND lcp_category = 'good'), COUNTIF(category = '0mb-1mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND lcp_category = 'ni'), COUNTIF(category = '0mb-1mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND lcp_category = 'poor'), COUNTIF(category = '0mb-1mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND lcp_category = 'good'), COUNTIF(category = '1mb-2mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND lcp_category = 'ni'), COUNTIF(category = '1mb-2mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND lcp_category = 'poor'), COUNTIF(category = '1mb-2mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND lcp_category = 'good'), COUNTIF(category = '2mb-3mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND lcp_category = 'ni'), COUNTIF(category = '2mb-3mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND lcp_category = 'poor'), COUNTIF(category = '2mb-3mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND lcp_category = 'good'), COUNTIF(category = '3mb-4mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND lcp_category = 'ni'), COUNTIF(category = '3mb-4mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND lcp_category = 'poor'), COUNTIF(category = '3mb-4mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND lcp_category = 'good'), COUNTIF(category = '4mb-5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND lcp_category = 'ni'), COUNTIF(category = '4mb-5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND lcp_category = 'poor'), COUNTIF(category = '4mb-5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND lcp_category = 'good'), COUNTIF(category = '>5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_good_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND lcp_category = 'ni'), COUNTIF(category = '>5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_ni_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND lcp_category = 'poor'), COUNTIF(category = '>5mb' AND lcp_category IS NOT NULL)), 4) AS lcp_poor_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND cls_category = 'good'), COUNTIF(category = '0mb-1mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND cls_category = 'ni'), COUNTIF(category = '0mb-1mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND cls_category = 'poor'), COUNTIF(category = '0mb-1mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND cls_category = 'good'), COUNTIF(category = '1mb-2mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND cls_category = 'ni'), COUNTIF(category = '1mb-2mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND cls_category = 'poor'), COUNTIF(category = '1mb-2mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND cls_category = 'good'), COUNTIF(category = '2mb-3mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND cls_category = 'ni'), COUNTIF(category = '2mb-3mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND cls_category = 'poor'), COUNTIF(category = '2mb-3mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND cls_category = 'good'), COUNTIF(category = '3mb-4mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND cls_category = 'ni'), COUNTIF(category = '3mb-4mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND cls_category = 'poor'), COUNTIF(category = '3mb-4mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND cls_category = 'good'), COUNTIF(category = '4mb-5mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND cls_category = 'ni'), COUNTIF(category = '4mb-5mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND cls_category = 'poor'), COUNTIF(category = '4mb-5mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND cls_category = 'good'), COUNTIF(category = '>5mb' AND cls_category IS NOT NULL)), 4) AS cls_good_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND cls_category = 'ni'), COUNTIF(category = '>5mb' AND cls_category IS NOT NULL)), 4) AS cls_ni_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND cls_category = 'poor'), COUNTIF(category = '>5mb' AND cls_category IS NOT NULL)), 4) AS cls_poor_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND inp_category = 'good'), COUNTIF(category = '0mb-1mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND inp_category = 'ni'), COUNTIF(category = '0mb-1mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND inp_category = 'poor'), COUNTIF(category = '0mb-1mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND inp_category = 'good'), COUNTIF(category = '1mb-2mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND inp_category = 'ni'), COUNTIF(category = '1mb-2mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND inp_category = 'poor'), COUNTIF(category = '1mb-2mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND inp_category = 'good'), COUNTIF(category = '2mb-3mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND inp_category = 'ni'), COUNTIF(category = '2mb-3mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND inp_category = 'poor'), COUNTIF(category = '2mb-3mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND inp_category = 'good'), COUNTIF(category = '3mb-4mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND inp_category = 'ni'), COUNTIF(category = '3mb-4mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND inp_category = 'poor'), COUNTIF(category = '3mb-4mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND inp_category = 'good'), COUNTIF(category = '4mb-5mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND inp_category = 'ni'), COUNTIF(category = '4mb-5mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND inp_category = 'poor'), COUNTIF(category = '4mb-5mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND inp_category = 'good'), COUNTIF(category = '>5mb' AND inp_category IS NOT NULL)), 4) AS inp_good_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND inp_category = 'ni'), COUNTIF(category = '>5mb' AND inp_category IS NOT NULL)), 4) AS inp_ni_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND inp_category = 'poor'), COUNTIF(category = '>5mb' AND inp_category IS NOT NULL)), 4) AS inp_poor_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND fcp_category = 'good'), COUNTIF(category = '0mb-1mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND fcp_category = 'ni'), COUNTIF(category = '0mb-1mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND fcp_category = 'poor'), COUNTIF(category = '0mb-1mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND fcp_category = 'good'), COUNTIF(category = '1mb-2mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND fcp_category = 'ni'), COUNTIF(category = '1mb-2mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND fcp_category = 'poor'), COUNTIF(category = '1mb-2mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND fcp_category = 'good'), COUNTIF(category = '2mb-3mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND fcp_category = 'ni'), COUNTIF(category = '2mb-3mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND fcp_category = 'poor'), COUNTIF(category = '2mb-3mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND fcp_category = 'good'), COUNTIF(category = '3mb-4mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND fcp_category = 'ni'), COUNTIF(category = '3mb-4mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND fcp_category = 'poor'), COUNTIF(category = '3mb-4mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND fcp_category = 'good'), COUNTIF(category = '4mb-5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND fcp_category = 'ni'), COUNTIF(category = '4mb-5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND fcp_category = 'poor'), COUNTIF(category = '4mb-5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND fcp_category = 'good'), COUNTIF(category = '>5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_good_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND fcp_category = 'ni'), COUNTIF(category = '>5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_ni_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND fcp_category = 'poor'), COUNTIF(category = '>5mb' AND fcp_category IS NOT NULL)), 4) AS fcp_poor_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND ttfb_category = 'good'), COUNTIF(category = '0mb-1mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND ttfb_category = 'ni'), COUNTIF(category = '0mb-1mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '0mb-1mb' AND ttfb_category = 'poor'), COUNTIF(category = '0mb-1mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_1mb_and_below,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND ttfb_category = 'good'), COUNTIF(category = '1mb-2mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND ttfb_category = 'ni'), COUNTIF(category = '1mb-2mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '1mb-2mb' AND ttfb_category = 'poor'), COUNTIF(category = '1mb-2mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_1mb_to_2mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND ttfb_category = 'good'), COUNTIF(category = '2mb-3mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND ttfb_category = 'ni'), COUNTIF(category = '2mb-3mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '2mb-3mb' AND ttfb_category = 'poor'), COUNTIF(category = '2mb-3mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_2mb_to_3mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND ttfb_category = 'good'), COUNTIF(category = '3mb-4mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND ttfb_category = 'ni'), COUNTIF(category = '3mb-4mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '3mb-4mb' AND ttfb_category = 'poor'), COUNTIF(category = '3mb-4mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_3mb_to_4mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND ttfb_category = 'good'), COUNTIF(category = '4mb-5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND ttfb_category = 'ni'), COUNTIF(category = '4mb-5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '4mb-5mb' AND ttfb_category = 'poor'), COUNTIF(category = '4mb-5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_4mb_to_5mb,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND ttfb_category = 'good'), COUNTIF(category = '>5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_good_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND ttfb_category = 'ni'), COUNTIF(category = '>5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_ni_pct_5mb_and_above,
  ROUND(SAFE_DIVIDE(COUNTIF(category = '>5mb' AND ttfb_category = 'poor'), COUNTIF(category = '>5mb' AND ttfb_category IS NOT NULL)), 4) AS ttfb_poor_pct_5mb_and_above
FROM
  categorised_data
GROUP BY
  client,
  is_root_page
ORDER BY
  client,
  is_root_page
