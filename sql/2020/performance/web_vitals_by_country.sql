#standardSQL
# Core WebVitals by country

CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(good, (good + needs_improvement + poor)) >= 0.75
);

CREATE TEMP FUNCTION IS_POOR(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  SAFE_DIVIDE(poor, (good + needs_improvement + poor)) >= 0.25
);

CREATE TEMP FUNCTION IS_NI(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  NOT IS_GOOD(good, needs_improvement, poor) AND
  NOT IS_POOR(good, needs_improvement, poor)
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

WITH
base AS (
  SELECT
    origin,
    country_code,

    SUM(fast_fid) / SUM(fast_fid + avg_fid + slow_fid) AS fast_fid,
    SUM(avg_fid) / SUM(fast_fid + avg_fid + slow_fid) AS avg_fid,
    SUM(slow_fid) / SUM(fast_fid + avg_fid + slow_fid) AS slow_fid,

    SUM(fast_lcp) / SUM(fast_lcp + avg_lcp + slow_lcp) AS fast_lcp,
    SUM(avg_lcp) / SUM(fast_lcp + avg_lcp + slow_lcp) AS avg_lcp,
    SUM(slow_lcp) / SUM(fast_lcp + avg_lcp + slow_lcp) AS slow_lcp,

    SUM(small_cls) / SUM(small_cls + medium_cls + large_cls) AS small_cls,
    SUM(medium_cls) / SUM(small_cls + medium_cls + large_cls) AS medium_cls,
    SUM(large_cls) / SUM(small_cls + medium_cls + large_cls) AS large_cls,

    SUM(fast_fcp) / SUM(fast_fcp + avg_fcp + slow_fcp) AS fast_fcp,
    SUM(avg_fcp) / SUM(fast_fcp + avg_fcp + slow_fcp) AS avg_fcp,
    SUM(slow_fcp) / SUM(fast_fcp + avg_fcp + slow_fcp) AS slow_fcp,

    SUM(fast_ttfb) / SUM(fast_ttfb + avg_ttfb + slow_ttfb) AS fast_ttfb,
    SUM(avg_ttfb) / SUM(fast_ttfb + avg_ttfb + slow_ttfb) AS avg_ttfb,
    SUM(slow_ttfb) / SUM(fast_ttfb + avg_ttfb + slow_ttfb) AS slow_ttfb

  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202008
  GROUP BY
    origin,
    country_code
)

SELECT
  `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS country,

  COUNT(DISTINCT origin) AS total_origins,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_fid, avg_fid, slow_fid) AND
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AND
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_cwv_good,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    ))
  ) AS pct_lcp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    ))
  ) AS pct_lcp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL
    ))
  ) AS pct_lcp_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL
    ))
  ) AS pct_fid_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(fast_fid, avg_fid, slow_fid), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL
    ))
  ) AS pct_fid_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(fast_fid, avg_fid, slow_fid), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL
    ))
  ) AS pct_fid_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_cls_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_cls_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_cls_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    ))
  ) AS pct_fcp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    ))
  ) AS pct_fcp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL
    ))
  ) AS pct_fcp_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    ))
  ) AS pct_ttfb_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    ))
  ) AS pct_ttfb_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL
    ))
  ) AS pct_ttfb_poor

FROM
  base
GROUP BY
  country
