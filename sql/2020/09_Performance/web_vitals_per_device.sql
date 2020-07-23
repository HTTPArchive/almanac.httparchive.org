#standardSQL
# TODO: add FCP and TTFB

WITH
  base AS (
  SELECT
    # remove literals after switching to country table
    202006 AS yyyymm,
    'pt' AS country_code,
    origin,
    # to exclude dimension from segmentation
    #'all' AS device,
    form_factor.name AS device,
    effective_connection_type.name AS network,
    layout_instability,
    largest_contentful_paint,
    first_input
  FROM
    # change to `chrome-ux-report.experimental.country`
    `chrome-ux-report.country_zw.202006`
  WHERE
    form_factor.name in ('desktop','phone')
    # filtered by origin for debug
    #origin = "http://borwap.com"
    # uncomment for country table
    #yyyymm = 202006
  ),
  dimensions AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network
  FROM
    base
  GROUP BY
    yyyymm,
    country_code,
    origin,
    device,
    network
  ),
  cls AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network,
    ROUND(SUM(IF(bin.start < 0.1, bin.density, 0)), 4) AS small,
    ROUND(SUM(IF(bin.start > 0.1 AND bin.start < 0.25, bin.density, 0)), 4) AS medium,
    ROUND(SUM(IF(bin.start >= 0.25, bin.density, 0)), 4) AS large,
    `chrome-ux-report`.experimental.PERCENTILE_NUMERIC(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(layout_instability.cumulative_layout_shift.histogram.bin) AS bin
  WHERE
    bin IS NOT NULL
  GROUP BY
    yyyymm,
    country_code,
    origin,
    device,
    network
  ),
  lcp AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network,
    ROUND(SUM(IF(bin.start < 2500, bin.density, 0)), 4) AS fast,
    ROUND(SUM(IF(bin.start >= 2500 AND bin.start < 4000, bin.density, 0)), 4) AS avg,
    ROUND(SUM(IF(bin.start >= 4000, bin.density, 0)), 4) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(largest_contentful_paint.histogram.bin) AS bin
  WHERE
    bin IS NOT NULL
  GROUP BY
    yyyymm,
    country_code,
    origin,
    device,
    network
  ),
  fid AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network,
    ROUND(SUM(IF(bin.start < 100, bin.density, 0)), 4) AS fast,
    ROUND(SUM(IF(bin.start >= 100 AND bin.start < 300, bin.density, 0)), 4) AS avg,
    ROUND(SUM(IF(bin.start >= 300, bin.density, 0)), 4) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(first_input.delay.histogram.bin) AS bin
  WHERE
    bin IS NOT NULL
  GROUP BY
    yyyymm,
    country_code,
    origin,
    device,
    network
  ),
  granular_metrics AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network,
    cls.small AS small_cls,
    cls.medium AS medium_cls,
    cls.large AS large_cls,
    cls.p75 AS p75_cls,

    lcp.fast AS fast_lcp,
    lcp.avg AS avg_lcp,
    lcp.slow AS slow_lcp,
    lcp.p75 AS p75_lcp,

    fid.fast AS fast_fid,
    fid.avg AS avg_fid,
    fid.slow AS slow_fid,
    fid.p75 AS p75_fid,
  FROM
    dimensions
  LEFT JOIN
    cls
  USING
    (yyyymm, country_code, origin, device, network)
  LEFT JOIN
    lcp
  USING
    (yyyymm, country_code, origin, device, network)
  LEFT JOIN
    fid
  USING
    (yyyymm, country_code, origin, device, network)),
  adjusted_metrics AS (
  SELECT
    yyyymm,
    country_code,
    origin,
    device,
    network,
    SAFE_DIVIDE(fast_lcp, fast_lcp+avg_lcp+slow_lcp) AS fast_lcp_adjusted,
    SAFE_DIVIDE(avg_lcp, fast_lcp+avg_lcp+slow_lcp) AS avg_lcp_adjusted,
    SAFE_DIVIDE(slow_lcp, fast_lcp+avg_lcp+slow_lcp) AS slow_lcp_adjusted,

    SAFE_DIVIDE(fast_fid, fast_fid+avg_fid+slow_fid) AS fast_fid_adjusted,
    SAFE_DIVIDE(avg_fid, fast_fid+avg_fid+slow_fid) AS avg_fid_adjusted,
    SAFE_DIVIDE(slow_fid, fast_fid+avg_fid+slow_fid) AS slow_fid_adjusted,

    SAFE_DIVIDE(small_cls, small_cls+medium_cls+large_cls) AS small_cls_adjusted,
    SAFE_DIVIDE(medium_cls, small_cls+medium_cls+large_cls) AS medium_cls_adjusted,
    SAFE_DIVIDE(large_cls, small_cls+medium_cls+large_cls) AS large_cls_adjusted,

  FROM
    granular_metrics)

SELECT
  yyyymm,
  country_code,
  device,
  network,
  COUNT(0) AS total_origins,
  
  ROUND(COUNTIF( fast_lcp_adjusted >= 0.75 AND fast_fid_adjusted >= 0.75 AND small_cls_adjusted >= 0.75) * 100 / COUNT(0), 2) AS pct_corewebvitals_pass,
  
  ROUND(COUNTIF( fast_lcp_adjusted >= 0.75) * 100 / COUNT(0), 2) AS pct_corewebvitals_lcp_good,
  ROUND(COUNTIF( fast_lcp_adjusted < 0.75 AND slow_lcp_adjusted < 0.25) * 100 / COUNT(0), 2) AS pct_corewebvitals_lcp_ni,
  ROUND(COUNTIF( slow_lcp_adjusted >= 0.25 OR slow_lcp_adjusted IS NULL) * 100 / COUNT(0), 2) AS pct_corewebvitals_lcp_poor,
  
  ROUND(COUNTIF( fast_fid_adjusted >= 0.75) * 100 / COUNT(0), 2) AS pct_corewebvitals_fid_good,
  ROUND(COUNTIF( fast_fid_adjusted < 0.75 AND slow_fid_adjusted < 0.25) * 100 / COUNT(0), 2) AS pct_corewebvitals_fid_ni,
  ROUND(COUNTIF( slow_fid_adjusted >= 0.25 OR slow_fid_adjusted IS NULL) * 100 / COUNT(0), 2) AS pct_corewebvitals_fid_poor,
  
  ROUND(COUNTIF( small_cls_adjusted >= 0.75) * 100 / COUNT(0), 2) AS pct_corewebvitals_cls_good,
  ROUND(COUNTIF( small_cls_adjusted < 0.75 AND large_cls_adjusted < 0.25) * 100 / COUNT(0), 2) AS pct_corewebvitals_cls_ni,
  ROUND(COUNTIF( large_cls_adjusted >= 0.25 OR large_cls_adjusted IS NULL) * 100 / COUNT(0), 2) AS pct_corewebvitals_cls_poor,

FROM
  adjusted_metrics
GROUP BY
  yyyymm,
  country_code,
  device,
  network
# exclude small segments
#HAVING total_origins > 1000