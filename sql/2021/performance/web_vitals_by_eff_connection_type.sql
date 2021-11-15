#standardSQL
# WebVitals by effective connection type

CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, (good + needs_improvement + poor)) >= 0.75
);

CREATE TEMP FUNCTION IS_NI (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, (good + needs_improvement + poor)) < 0.75 AND
  SAFE_DIVIDE(poor, (good + needs_improvement + poor)) < 0.25
);

CREATE TEMP FUNCTION IS_POOR (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(poor, (good + needs_improvement + poor)) >= 0.25
);

CREATE TEMP FUNCTION IS_NON_ZERO (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

WITH
base AS (
  SELECT
    origin,
    effective_connection_type.name AS network,
    layout_instability,
    largest_contentful_paint,
    first_input,
    first_contentful_paint,
    experimental.time_to_first_byte AS time_to_first_byte
  FROM
    `chrome-ux-report.all.202107`
),

cls AS (
  SELECT
    origin,
    network,
    SUM(IF(bin.start < 0.1, bin.density, 0)) AS small,
    SUM(IF(bin.start > 0.1 AND bin.start < 0.25, bin.density, 0)) AS medium,
    SUM(IF(bin.start >= 0.25, bin.density, 0)) AS large,
    `chrome-ux-report`.experimental.PERCENTILE_NUMERIC(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(layout_instability.cumulative_layout_shift.histogram.bin) AS bin
  GROUP BY
    origin,
    network
),

lcp AS (
  SELECT
    origin,
    network,
    SUM(IF(bin.start < 2500, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 2500 AND bin.start < 4000, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 4000, bin.density, 0)) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(largest_contentful_paint.histogram.bin) AS bin
  GROUP BY
    origin,
    network
),

fid AS (
  SELECT
    origin,
    network,
    SUM(IF(bin.start < 100, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 100 AND bin.start < 300, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 300, bin.density, 0)) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(first_input.delay.histogram.bin) AS bin
  GROUP BY
    origin,
    network
),

fcp AS (
  SELECT
    origin,
    network,
    SUM(IF(bin.start < 1800, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 1800 AND bin.start < 3000, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 3000, bin.density, 0)) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(first_contentful_paint.histogram.bin) AS bin
  GROUP BY
    origin,
    network
),

ttfb AS (
  SELECT
    origin,
    network,
    SUM(IF(bin.start < 500, bin.density, 0)) AS fast,
    SUM(IF(bin.start >= 500 AND bin.start < 1500, bin.density, 0)) AS avg,
    SUM(IF(bin.start >= 1500, bin.density, 0)) AS slow,
    `chrome-ux-report`.experimental.PERCENTILE(ARRAY_AGG(bin), 75) AS p75
  FROM
    base
  LEFT JOIN
    UNNEST(time_to_first_byte.histogram.bin) AS bin
  GROUP BY
    origin,
    network
),

granular_metrics AS (
  SELECT
    origin,
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

    fcp.fast AS fast_fcp,
    fcp.avg AS avg_fcp,
    fcp.slow AS slow_fcp,
    fcp.p75 AS p75_fcp,

    ttfb.fast AS fast_ttfb,
    ttfb.avg AS avg_ttfb,
    ttfb.slow AS slow_ttfb,
    ttfb.p75 AS p75_ttfb
  FROM
    cls
  LEFT JOIN
    lcp
  USING
    (origin, network)
  LEFT JOIN
    fid
  USING
    (origin, network)
  LEFT JOIN
    fcp
  USING
    (origin, network)
  LEFT JOIN
    ttfb
  USING
    (origin, network)
)

SELECT
  network,

  COUNT(DISTINCT origin) AS total_origins,

  # Good CWV with optional FID
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_fid, avg_fid, slow_fid) IS NOT FALSE AND
        IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
        IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
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

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_poor

FROM
  granular_metrics
GROUP BY
  network
