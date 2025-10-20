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

lcp_data AS (
  SELECT *
  FROM base_data
  WHERE lcp IS NOT NULL
),

cls_data AS (
  SELECT *
  FROM base_data
  WHERE cls IS NOT NULL
),

inp_data AS (
  SELECT *
  FROM base_data
  WHERE inp IS NOT NULL
),

fcp_data AS (
  SELECT *
  FROM base_data
  WHERE fcp IS NOT NULL
),

ttfb_data AS (
  SELECT *
  FROM base_data
  WHERE ttfb IS NOT NULL
),

-- LCP metrics
lcp_metrics AS (
  SELECT
    client,
    is_root_page,
    -- LCP Percentages by Page Size
    -- 1MB and below
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS lcp_good_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS lcp_ni_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS lcp_poor_pct_1mb_and_below,
    -- 1MB to 2MB
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS lcp_good_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS lcp_ni_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS lcp_poor_pct_1mb_to_2mb,
    -- 2MB to 3MB
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS lcp_good_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS lcp_ni_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS lcp_poor_pct_2mb_to_3mb,
    -- 3MB to 4MB
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS lcp_good_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS lcp_ni_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS lcp_poor_pct_3mb_to_4mb,
    -- 4MB to 5MB
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS lcp_good_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS lcp_ni_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS lcp_poor_pct_4mb_to_5mb,
    -- 5MB and above
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND lcp <= 2.5) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS lcp_good_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND lcp > 2.5 AND lcp <= 4.0) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS lcp_ni_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND lcp > 4.0) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS lcp_poor_pct_5mb_and_above
  FROM
    lcp_data
  GROUP BY
    client,
    is_root_page
),

-- CLS metrics
cls_metrics AS (
  SELECT
    client,
    is_root_page,
    -- CLS Percentages by Page Size
    -- 1MB and below
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS cls_good_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS cls_ni_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS cls_poor_pct_1mb_and_below,
    -- 1MB to 2MB
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS cls_good_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS cls_ni_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS cls_poor_pct_1mb_to_2mb,
    -- 2MB to 3MB
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS cls_good_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS cls_ni_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS cls_poor_pct_2mb_to_3mb,
    -- 3MB to 4MB
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS cls_good_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS cls_ni_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS cls_poor_pct_3mb_to_4mb,
    -- 4MB to 5MB
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS cls_good_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS cls_ni_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS cls_poor_pct_4mb_to_5mb,
    -- 5MB and above
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND cls <= 0.1) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS cls_good_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND cls > 0.1 AND cls <= 0.25) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS cls_ni_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND cls > 0.25) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS cls_poor_pct_5mb_and_above
  FROM
    cls_data
  GROUP BY
    client,
    is_root_page
),

-- INP metrics
inp_metrics AS (
  SELECT
    client,
    is_root_page,
    -- INP Percentages by Page Size
    -- 1MB and below
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND inp <= 200) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS inp_good_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS inp_ni_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND inp > 500) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS inp_poor_pct_1mb_and_below,
    -- 1MB to 2MB
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS inp_good_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS inp_ni_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND inp > 500) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS inp_poor_pct_1mb_to_2mb,
    -- 2MB to 3MB
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS inp_good_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS inp_ni_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND inp > 500) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS inp_poor_pct_2mb_to_3mb,
    -- 3MB to 4MB
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS inp_good_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS inp_ni_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND inp > 500) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS inp_poor_pct_3mb_to_4mb,
    -- 4MB to 5MB
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS inp_good_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS inp_ni_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND inp > 500) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS inp_poor_pct_4mb_to_5mb,
    -- 5MB and above
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS inp_good_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND inp > 200 AND inp <= 500) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS inp_ni_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND inp > 500) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS inp_poor_pct_5mb_and_above
  FROM
    inp_data
  GROUP BY
    client,
    is_root_page
),

-- FCP metrics
fcp_metrics AS (
  SELECT
    client,
    is_root_page,
    -- FCP Percentages by Page Size
    -- 1MB and below
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS fcp_good_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS fcp_ni_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS fcp_poor_pct_1mb_and_below,
    -- 1MB to 2MB
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS fcp_good_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS fcp_ni_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS fcp_poor_pct_1mb_to_2mb,
    -- 2MB to 3MB
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS fcp_good_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS fcp_ni_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS fcp_poor_pct_2mb_to_3mb,
    -- 3MB to 4MB
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS fcp_good_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS fcp_ni_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS fcp_poor_pct_3mb_to_4mb,
    -- 4MB to 5MB
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS fcp_good_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS fcp_ni_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS fcp_poor_pct_4mb_to_5mb,
    -- 5MB and above
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND fcp <= 1.8) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS fcp_good_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND fcp > 1.8 AND fcp <= 3.0) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS fcp_ni_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND fcp > 3.0) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS fcp_poor_pct_5mb_and_above
  FROM
    fcp_data
  GROUP BY
    client,
    is_root_page
),

-- TTFB metrics
ttfb_metrics AS (
  SELECT
    client,
    is_root_page,
    -- TTFB Percentages by Page Size
    -- 1MB and below
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS ttfb_good_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS ttfb_ni_pct_1mb_and_below,
    ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS ttfb_poor_pct_1mb_and_below,
    -- 1MB to 2MB
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS ttfb_good_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS ttfb_ni_pct_1mb_to_2mb,
    ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS ttfb_poor_pct_1mb_to_2mb,
    -- 2MB to 3MB
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS ttfb_good_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS ttfb_ni_pct_2mb_to_3mb,
    ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS ttfb_poor_pct_2mb_to_3mb,
    -- 3MB to 4MB
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS ttfb_good_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS ttfb_ni_pct_3mb_to_4mb,
    ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS ttfb_poor_pct_3mb_to_4mb,
    -- 4MB to 5MB
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS ttfb_good_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS ttfb_ni_pct_4mb_to_5mb,
    ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS ttfb_poor_pct_4mb_to_5mb,
    -- 5MB and above
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND ttfb <= 800) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS ttfb_good_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND ttfb > 800 AND ttfb <= 1800) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS ttfb_ni_pct_5mb_and_above,
    ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND ttfb > 1800) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS ttfb_poor_pct_5mb_and_above
  FROM
    ttfb_data
  GROUP BY
    client,
    is_root_page
)

SELECT
  COALESCE(lcp.client, cls.client, inp.client, fcp.client, ttfb.client) AS client,
  COALESCE(lcp.is_root_page, cls.is_root_page, inp.is_root_page, fcp.is_root_page, ttfb.is_root_page) AS is_root_page,
  -- LCP metrics
  lcp.lcp_good_pct_1mb_and_below,
  lcp.lcp_ni_pct_1mb_and_below,
  lcp.lcp_poor_pct_1mb_and_below,
  lcp.lcp_good_pct_1mb_to_2mb,
  lcp.lcp_ni_pct_1mb_to_2mb,
  lcp.lcp_poor_pct_1mb_to_2mb,
  lcp.lcp_good_pct_2mb_to_3mb,
  lcp.lcp_ni_pct_2mb_to_3mb,
  lcp.lcp_poor_pct_2mb_to_3mb,
  lcp.lcp_good_pct_3mb_to_4mb,
  lcp.lcp_ni_pct_3mb_to_4mb,
  lcp.lcp_poor_pct_3mb_to_4mb,
  lcp.lcp_good_pct_4mb_to_5mb,
  lcp.lcp_ni_pct_4mb_to_5mb,
  lcp.lcp_poor_pct_4mb_to_5mb,
  lcp.lcp_good_pct_5mb_and_above,
  lcp.lcp_ni_pct_5mb_and_above,
  lcp.lcp_poor_pct_5mb_and_above,
  -- CLS metrics
  cls.cls_good_pct_1mb_and_below,
  cls.cls_ni_pct_1mb_and_below,
  cls.cls_poor_pct_1mb_and_below,
  cls.cls_good_pct_1mb_to_2mb,
  cls.cls_ni_pct_1mb_to_2mb,
  cls.cls_poor_pct_1mb_to_2mb,
  cls.cls_good_pct_2mb_to_3mb,
  cls.cls_ni_pct_2mb_to_3mb,
  cls.cls_poor_pct_2mb_to_3mb,
  cls.cls_good_pct_3mb_to_4mb,
  cls.cls_ni_pct_3mb_to_4mb,
  cls.cls_poor_pct_3mb_to_4mb,
  cls.cls_good_pct_4mb_to_5mb,
  cls.cls_ni_pct_4mb_to_5mb,
  cls.cls_poor_pct_4mb_to_5mb,
  cls.cls_good_pct_5mb_and_above,
  cls.cls_ni_pct_5mb_and_above,
  cls.cls_poor_pct_5mb_and_above,
  -- INP metrics
  inp.inp_good_pct_1mb_and_below,
  inp.inp_ni_pct_1mb_and_below,
  inp.inp_poor_pct_1mb_and_below,
  inp.inp_good_pct_1mb_to_2mb,
  inp.inp_ni_pct_1mb_to_2mb,
  inp.inp_poor_pct_1mb_to_2mb,
  inp.inp_good_pct_2mb_to_3mb,
  inp.inp_ni_pct_2mb_to_3mb,
  inp.inp_poor_pct_2mb_to_3mb,
  inp.inp_good_pct_3mb_to_4mb,
  inp.inp_ni_pct_3mb_to_4mb,
  inp.inp_poor_pct_3mb_to_4mb,
  inp.inp_good_pct_4mb_to_5mb,
  inp.inp_ni_pct_4mb_to_5mb,
  inp.inp_poor_pct_4mb_to_5mb,
  inp.inp_good_pct_5mb_and_above,
  inp.inp_ni_pct_5mb_and_above,
  inp.inp_poor_pct_5mb_and_above,
  -- FCP metrics
  fcp.fcp_good_pct_1mb_and_below,
  fcp.fcp_ni_pct_1mb_and_below,
  fcp.fcp_poor_pct_1mb_and_below,
  fcp.fcp_good_pct_1mb_to_2mb,
  fcp.fcp_ni_pct_1mb_to_2mb,
  fcp.fcp_poor_pct_1mb_to_2mb,
  fcp.fcp_good_pct_2mb_to_3mb,
  fcp.fcp_ni_pct_2mb_to_3mb,
  fcp.fcp_poor_pct_2mb_to_3mb,
  fcp.fcp_good_pct_3mb_to_4mb,
  fcp.fcp_ni_pct_3mb_to_4mb,
  fcp.fcp_poor_pct_3mb_to_4mb,
  fcp.fcp_good_pct_4mb_to_5mb,
  fcp.fcp_ni_pct_4mb_to_5mb,
  fcp.fcp_poor_pct_4mb_to_5mb,
  fcp.fcp_good_pct_5mb_and_above,
  fcp.fcp_ni_pct_5mb_and_above,
  fcp.fcp_poor_pct_5mb_and_above,
  -- TTFB metrics
  ttfb.ttfb_good_pct_1mb_and_below,
  ttfb.ttfb_ni_pct_1mb_and_below,
  ttfb.ttfb_poor_pct_1mb_and_below,
  ttfb.ttfb_good_pct_1mb_to_2mb,
  ttfb.ttfb_ni_pct_1mb_to_2mb,
  ttfb.ttfb_poor_pct_1mb_to_2mb,
  ttfb.ttfb_good_pct_2mb_to_3mb,
  ttfb.ttfb_ni_pct_2mb_to_3mb,
  ttfb.ttfb_poor_pct_2mb_to_3mb,
  ttfb.ttfb_good_pct_3mb_to_4mb,
  ttfb.ttfb_ni_pct_3mb_to_4mb,
  ttfb.ttfb_poor_pct_3mb_to_4mb,
  ttfb.ttfb_good_pct_4mb_to_5mb,
  ttfb.ttfb_ni_pct_4mb_to_5mb,
  ttfb.ttfb_poor_pct_4mb_to_5mb,
  ttfb.ttfb_good_pct_5mb_and_above,
  ttfb.ttfb_ni_pct_5mb_and_above,
  ttfb.ttfb_poor_pct_5mb_and_above
FROM
  lcp_metrics lcp
FULL OUTER JOIN cls_metrics cls ON lcp.client = cls.client AND lcp.is_root_page = cls.is_root_page
FULL OUTER JOIN inp_metrics inp ON COALESCE(lcp.client, cls.client) = inp.client AND COALESCE(lcp.is_root_page, cls.is_root_page) = inp.is_root_page
FULL OUTER JOIN fcp_metrics fcp ON COALESCE(lcp.client, cls.client, inp.client) = fcp.client AND COALESCE(lcp.is_root_page, cls.is_root_page, inp.is_root_page) = fcp.is_root_page
FULL OUTER JOIN ttfb_metrics ttfb ON COALESCE(lcp.client, cls.client, inp.client, fcp.client) = ttfb.client AND COALESCE(lcp.is_root_page, cls.is_root_page, inp.is_root_page, fcp.is_root_page) = ttfb.is_root_page
ORDER BY
  client, is_root_page
