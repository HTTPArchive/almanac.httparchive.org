#standardSQL
# Core WebVitals per effective connection type

CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NI (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) < 0.75
  AND poor / (good + needs_improvement + poor) < 0.25
);

CREATE TEMP FUNCTION IS_POOR (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  poor / (good + needs_improvement + poor) >= 0.25
);

CREATE TEMP FUNCTION IS_NON_ZERO (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

WITH
  base AS (
  SELECT
    yyyymm,
    origin,
    'all' AS country_code,
    'all' AS device,
    effective_connection_type.name AS network,
    layout_instability,
    largest_contentful_paint,
    first_input
  FROM
    `chrome-ux-report.experimental.country`
  WHERE
    form_factor.name in ('desktop','phone')
    AND yyyymm = 202006
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
    SUM(IF(bin.start < 0.1, bin.density, 0)) AS small,
    SUM(IF(bin.start > 0.1 AND bin.start < 0.25, bin.density, 0)) AS medium,
    SUM(IF(bin.start >= 0.25, bin.density, 0)) AS large,
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
    SUM(IF(bin.start < 2500, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 2500 AND bin.start < 4000, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 4000, bin.density, 0)) AS slow,
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
    SUM(IF(bin.start < 100, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 100 AND bin.start < 300, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 300, bin.density, 0)) AS slow,
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
    (yyyymm, country_code, origin, device, network))

SELECT
  yyyymm,
  country_code,
  device,
  network,
  
  COUNT(DISTINCT origin) AS total_origins,
  
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_GOOD(fast_fid, avg_fid, slow_fid) AND
          IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
          IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AND
          IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
          IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cwv_good,
  
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_good,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_NI(fast_lcp, avg_lcp, slow_lcp), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_ni,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_POOR(fast_lcp, avg_lcp, slow_lcp), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_poor,
  
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_good,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_NI(fast_fid, avg_fid, slow_fid), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_ni,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_POOR(fast_fid, avg_fid, slow_fid), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_poor,
  
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_good,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_NI(small_cls, medium_cls, large_cls), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_ni,
  SAFE_DIVIDE(
      COUNT(DISTINCT IF(
          IS_POOR(small_cls, medium_cls, large_cls), origin, NULL)), 
      COUNT(DISTINCT IF(
          IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_poor,

FROM
  granular_metrics
GROUP BY
  yyyymm,
  country_code,
  device,
  network