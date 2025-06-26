WITH metrics_data AS (
  SELECT
    date,
    client,
    is_root_page,
    CAST(JSON_VALUE(summary, '$.bytesTotal') AS INT64) AS bytes_total,
    CAST(JSON_VALUE(summary, '$.crux.metrics.largest_contentful_paint.percentiles.p75') AS FLOAT64) AS lcp,
    CAST(JSON_VALUE(summary, '$.crux.metrics.cumulative_layout_shift.percentiles.p75') AS FLOAT64) AS cls,
    CAST(JSON_VALUE(summary, '$.crux.metrics.interaction_to_next_paint.percentiles.p75') AS FLOAT64) AS inp,
    CAST(JSON_VALUE(summary, '$.crux.metrics.first_contentful_paint.percentiles.p75') AS FLOAT64) AS fcp,
    CAST(JSON_VALUE(summary, '$.crux.metrics.experimental_time_to_first_byte.percentiles.p75') AS FLOAT64) AS ttfb
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
)

SELECT
  client,
  is_root_page,
  -- LCP metrics
  -- 1mb and below
  ROUND(APPROX_QUANTILES(IF(bytes_total <= 1048576, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_1mb_and_below,
  -- 1mb to 2mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 1048576 AND bytes_total <= 2097152, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_1mb_to_2mb,
  -- 2mb to 3mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 2097152 AND bytes_total <= 3145728, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_2mb_to_3mb,
  -- 3mb to 4mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 3145728 AND bytes_total <= 4194304, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_3mb_to_4mb,
  -- 4mb and 5mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 4194304 AND bytes_total <= 5242880, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_4mb_to_5mb,
  -- 5mb and above
  ROUND(APPROX_QUANTILES(IF(bytes_total >= 5242880, lcp, NULL), 1000)[OFFSET(750)] / 1000, 2) AS p75_lcp_5mb_and_above,

  -- CLS metrics
  -- 1mb and below
  ROUND(APPROX_QUANTILES(IF(bytes_total <= 1048576, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_1mb_and_below,
  -- 1mb to 2mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 1048576 AND bytes_total <= 2097152, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_1mb_to_2mb,
  -- 2mb to 3mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 2097152 AND bytes_total <= 3145728, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_2mb_to_3mb,
  -- 3mb to 4mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 3145728 AND bytes_total <= 4194304, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_3mb_to_4mb,
  -- 4mb and 5mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 4194304 AND bytes_total <= 5242880, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_4mb_to_5mb,
  -- 5mb and above
  ROUND(APPROX_QUANTILES(IF(bytes_total >= 5242880, cls, NULL), 1000)[OFFSET(750)], 2) AS p75_cls_5mb_and_above,

  -- INP metrics
  -- 1mb and below
  ROUND(APPROX_QUANTILES(IF(bytes_total <= 1048576, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_1mb_and_below,
  -- 1mb to 2mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 1048576 AND bytes_total <= 2097152, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_1mb_to_2mb,
  -- 2mb to 3mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 2097152 AND bytes_total <= 3145728, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_2mb_to_3mb,
  -- 3mb to 4mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 3145728 AND bytes_total <= 4194304, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_3mb_to_4mb,
  -- 4mb and 5mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 4194304 AND bytes_total <= 5242880, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_4mb_to_5mb,
  -- 5mb and above
  ROUND(APPROX_QUANTILES(IF(bytes_total >= 5242880, inp, NULL), 1000)[OFFSET(750)], 2) AS p75_inp_5mb_and_above,

  -- FCP metrics
  -- 1mb and below
  ROUND(APPROX_QUANTILES(IF(bytes_total <= 1048576, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_1mb_and_below,
  -- 1mb to 2mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 1048576 AND bytes_total <= 2097152, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_1mb_to_2mb,
  -- 2mb to 3mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 2097152 AND bytes_total <= 3145728, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_2mb_to_3mb,
  -- 3mb to 4mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 3145728 AND bytes_total <= 4194304, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_3mb_to_4mb,
  -- 4mb and 5mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 4194304 AND bytes_total <= 5242880, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_4mb_to_5mb,
  -- 5mb and above
  ROUND(APPROX_QUANTILES(IF(bytes_total >= 5242880, fcp, NULL), 1000)[OFFSET(750)], 2) AS p75_fcp_5mb_and_above,

  -- TTFB metrics
  -- 1mb and below
  ROUND(APPROX_QUANTILES(IF(bytes_total <= 1048576, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_1mb_and_below,
  -- 1mb to 2mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 1048576 AND bytes_total <= 2097152, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_1mb_to_2mb,
  -- 2mb to 3mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 2097152 AND bytes_total <= 3145728, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_2mb_to_3mb,
  -- 3mb to 4mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 3145728 AND bytes_total <= 4194304, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_3mb_to_4mb,
  -- 4mb and 5mb
  ROUND(APPROX_QUANTILES(IF(bytes_total > 4194304 AND bytes_total <= 5242880, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_4mb_to_5mb,
  -- 5mb and above
  ROUND(APPROX_QUANTILES(IF(bytes_total >= 5242880, ttfb, NULL), 1000)[OFFSET(750)], 2) AS p75_ttfb_5mb_and_above

FROM
  metrics_data
GROUP BY
  client,
  is_root_page
ORDER BY
  client
