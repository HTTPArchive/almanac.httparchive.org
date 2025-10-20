WITH metrics_data AS (
  SELECT
    date,
    client,
    is_root_page,
    CAST(JSON_VALUE(summary.bytesTotal) AS INT64) AS bytes_total,
    -- these are page level CrUX metrics, pages may not have all / any metrics available, but do represent the user experience of the measured page weight vs. origin.
    CAST(JSON_VALUE(summary.crux.metrics.largest_contentful_paint.percentiles.p75) AS FLOAT64) / 1000 AS lcp,
    CAST(JSON_VALUE(summary.crux.metrics.cumulative_layout_shift.percentiles.p75) AS FLOAT64) AS cls,
    CAST(JSON_VALUE(summary.crux.metrics.interaction_to_next_paint.percentiles.p75) AS FLOAT64) AS inp
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    -- Ensure all CWV metrics are available
    CAST(JSON_VALUE(summary.crux.metrics.largest_contentful_paint.percentiles.p75) AS FLOAT64) IS NOT NULL AND
    CAST(JSON_VALUE(summary.crux.metrics.cumulative_layout_shift.percentiles.p75) AS FLOAT64) IS NOT NULL AND
    CAST(JSON_VALUE(summary.crux.metrics.interaction_to_next_paint.percentiles.p75) AS FLOAT64) IS NOT NULL
)

SELECT
  client,
  is_root_page,
  -- Percentage of sites passing all Core Web Vitals (Good on LCP, CLS, and INP) by Page Size
  -- 1MB and below
  ROUND(100.0 * COUNTIF(bytes_total <= 1048576 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total <= 1048576), 0), 2) AS pass_all_cwv_pct_1mb_and_below,
  -- 1MB to 2MB
  ROUND(100.0 * COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 1048576 AND bytes_total <= 2097152), 0), 2) AS pass_all_cwv_pct_1mb_to_2mb,
  -- 2MB to 3MB
  ROUND(100.0 * COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 2097152 AND bytes_total <= 3145728), 0), 2) AS pass_all_cwv_pct_2mb_to_3mb,
  -- 3MB to 4MB
  ROUND(100.0 * COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 3145728 AND bytes_total <= 4194304), 0), 2) AS pass_all_cwv_pct_3mb_to_4mb,
  -- 4MB to 5MB
  ROUND(100.0 * COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 4194304 AND bytes_total <= 5242880), 0), 2) AS pass_all_cwv_pct_4mb_to_5mb,
  -- 5MB and above
  ROUND(100.0 * COUNTIF(bytes_total > 5242880 AND lcp <= 2.5 AND cls <= 0.1 AND inp <= 200) / NULLIF(COUNTIF(bytes_total > 5242880), 0), 2) AS pass_all_cwv_pct_5mb_and_above
FROM
  metrics_data
GROUP BY
  client,
  is_root_page
ORDER BY
  client
