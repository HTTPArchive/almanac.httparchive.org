WITH metrics_data AS (
  SELECT
    date,
    client,
    CAST(JSON_VALUE(summary.bytesTotal) AS INT64) AS bytes_total,
    -- these are page level CrUX metrics, pages may not have all / any metrics available, but do represent the user experience of the measured page weight vs. origin.
    CAST(JSON_VALUE(summary.crux.metrics.largest_contentful_paint.percentiles.p75) AS FLOAT64) AS lcp,
    CAST(JSON_VALUE(summary.crux.metrics.cumulative_layout_shift.percentiles.p75) AS FLOAT64) AS cls,
    CAST(JSON_VALUE(summary.crux.metrics.interaction_to_next_paint.percentiles.p75) AS FLOAT64) AS inp,
    CAST(JSON_VALUE(summary.crux.metrics.first_contentful_paint.percentiles.p75) AS FLOAT64) AS fcp,
    CAST(JSON_VALUE(summary.crux.metrics.experimental_time_to_first_byte.percentiles.p75) AS FLOAT64) AS ttfb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date >= '2024-07-01' AND -- noqa: CV09
    date <= '2025-07-01'
)

SELECT
  date,
  client,
  COUNT(DISTINCT IF(bytes_total > 0, bytes_total, NULL)) AS total_pages,

  -- Page Size metrics
  ROUND(APPROX_QUANTILES(bytes_total, 1000)[OFFSET(100)] / 1024, 2) AS p10_page_size_kb,
  ROUND(APPROX_QUANTILES(bytes_total, 1000)[OFFSET(250)] / 1024, 2) AS p25_page_size_kb,
  ROUND(APPROX_QUANTILES(bytes_total, 1000)[OFFSET(500)] / 1024, 2) AS p50_page_size_kb,
  ROUND(APPROX_QUANTILES(bytes_total, 1000)[OFFSET(750)] / 1024, 2) AS p75_page_size_kb,
  ROUND(APPROX_QUANTILES(bytes_total, 1000)[OFFSET(900)] / 1024, 2) AS p90_page_size_kb,

  -- LCP metrics
  ROUND(APPROX_QUANTILES(lcp, 1000)[OFFSET(100)], 2) AS p10_lcp,
  ROUND(APPROX_QUANTILES(lcp, 1000)[OFFSET(250)], 2) AS p25_lcp,
  ROUND(APPROX_QUANTILES(lcp, 1000)[OFFSET(500)], 2) AS p50_lcp,
  ROUND(APPROX_QUANTILES(lcp, 1000)[OFFSET(750)], 2) AS p75_lcp,
  ROUND(APPROX_QUANTILES(lcp, 1000)[OFFSET(900)], 2) AS p90_lcp,

  -- CLS metrics
  ROUND(APPROX_QUANTILES(cls, 1000)[OFFSET(100)], 3) AS p10_cls,
  ROUND(APPROX_QUANTILES(cls, 1000)[OFFSET(250)], 3) AS p25_cls,
  ROUND(APPROX_QUANTILES(cls, 1000)[OFFSET(500)], 3) AS p50_cls,
  ROUND(APPROX_QUANTILES(cls, 1000)[OFFSET(750)], 3) AS p75_cls,
  ROUND(APPROX_QUANTILES(cls, 1000)[OFFSET(900)], 3) AS p90_cls,

  -- INP metrics
  ROUND(APPROX_QUANTILES(inp, 1000)[OFFSET(100)], 2) AS p10_inp,
  ROUND(APPROX_QUANTILES(inp, 1000)[OFFSET(250)], 2) AS p25_inp,
  ROUND(APPROX_QUANTILES(inp, 1000)[OFFSET(500)], 2) AS p50_inp,
  ROUND(APPROX_QUANTILES(inp, 1000)[OFFSET(750)], 2) AS p75_inp,
  ROUND(APPROX_QUANTILES(inp, 1000)[OFFSET(900)], 2) AS p90_inp,

  -- FCP metrics
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(100)], 2) AS p10_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(250)], 2) AS p25_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(500)], 2) AS p50_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(750)], 2) AS p75_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(900)], 2) AS p90_fcp,

  -- TTFB metrics
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(100)], 2) AS p10_ttfb,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(250)], 2) AS p25_ttfb,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(500)], 2) AS p50_ttfb,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(750)], 2) AS p75_ttfb,
  ROUND(APPROX_QUANTILES(ttfb, 1000)[OFFSET(900)], 2) AS p90_ttfb,

  -- Good CWV percentages
  ROUND(COUNTIF(lcp <= 2500) / COUNT(0) * 100, 2) AS good_lcp_percent,
  ROUND(COUNTIF(cls <= 0.1) / COUNT(0) * 100, 2) AS good_cls_percent,
  ROUND(COUNTIF(inp <= 200) / COUNT(0) * 100, 2) AS good_inp_percent,
  ROUND(COUNTIF(fcp <= 1800) / COUNT(0) * 100, 2) AS good_fcp_percent,
  ROUND(COUNTIF(ttfb <= 800) / COUNT(0) * 100, 2) AS good_ttfb_percent

FROM
  metrics_data
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
