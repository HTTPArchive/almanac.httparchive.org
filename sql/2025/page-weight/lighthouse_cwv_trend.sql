WITH metrics_data AS (
  SELECT
    date,
    client,
    CAST(JSON_VALUE(summary.bytesTotal) AS INT64) AS bytes_total,
    CAST(JSON_VALUE(lighthouse.audits['largest-contentful-paint'].numericValue) AS FLOAT64) AS lcp,
    CAST(JSON_VALUE(lighthouse.audits['cumulative-layout-shift'].numericValue) AS FLOAT64) AS cls,
    CAST(JSON_VALUE(lighthouse.audits['total-blocking-time'].numericValue) AS FLOAT64) AS tbt,
    CAST(JSON_VALUE(lighthouse.audits['first-contentful-paint'].numericValue) AS FLOAT64) AS fcp,
    CAST(JSON_VALUE(lighthouse.audits['interactive'].numericValue) AS FLOAT64) AS tti,
    CAST(JSON_VALUE(lighthouse.categories.performance.score) AS FLOAT64) AS performance_score
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

  -- TBT metrics (as a proxy for FID/INP)
  ROUND(APPROX_QUANTILES(tbt, 1000)[OFFSET(100)], 2) AS p10_tbt,
  ROUND(APPROX_QUANTILES(tbt, 1000)[OFFSET(250)], 2) AS p25_tbt,
  ROUND(APPROX_QUANTILES(tbt, 1000)[OFFSET(500)], 2) AS p50_tbt,
  ROUND(APPROX_QUANTILES(tbt, 1000)[OFFSET(750)], 2) AS p75_tbt,
  ROUND(APPROX_QUANTILES(tbt, 1000)[OFFSET(900)], 2) AS p90_tbt,

  -- FCP metrics
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(100)], 2) AS p10_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(250)], 2) AS p25_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(500)], 2) AS p50_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(750)], 2) AS p75_fcp,
  ROUND(APPROX_QUANTILES(fcp, 1000)[OFFSET(900)], 2) AS p90_fcp,

  -- TTI metrics
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(100)], 2) AS p10_tti,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(250)], 2) AS p25_tti,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(500)], 2) AS p50_tti,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(750)], 2) AS p75_tti,
  ROUND(APPROX_QUANTILES(tti, 1000)[OFFSET(900)], 2) AS p90_tti,

  -- Performance Score metrics
  ROUND(APPROX_QUANTILES(performance_score, 1000)[OFFSET(900)] * 100, 2) AS p10_performance_score,
  ROUND(APPROX_QUANTILES(performance_score, 1000)[OFFSET(750)] * 100, 2) AS p25_performance_score,
  ROUND(APPROX_QUANTILES(performance_score, 1000)[OFFSET(500)] * 100, 2) AS p50_performance_score,
  ROUND(APPROX_QUANTILES(performance_score, 1000)[OFFSET(250)] * 100, 2) AS p75_performance_score,
  ROUND(APPROX_QUANTILES(performance_score, 1000)[OFFSET(100)] * 100, 2) AS p90_performance_score,

  -- Good CWV percentages
  ROUND(COUNTIF(lcp <= 2500) / COUNT(0) * 100, 2) AS good_lcp_percent,
  ROUND(COUNTIF(cls <= 0.1) / COUNT(0) * 100, 2) AS good_cls_percent,
  ROUND(COUNTIF(tbt <= 300) / COUNT(0) * 100, 2) AS good_tbt_percent,
  ROUND(COUNTIF(fcp <= 1800) / COUNT(0) * 100, 2) AS good_fcp_percent

FROM
  metrics_data
GROUP BY
  date,
  client
ORDER BY
  date DESC,
  client
