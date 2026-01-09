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
    date,
    origin,
    device,
    rank,

    fast_inp,
    avg_inp,
    slow_inp,

    fast_lcp,
    avg_lcp,
    slow_lcp,

    small_cls,
    medium_cls,
    large_cls,

    fast_fcp,
    avg_fcp,
    slow_fcp,

    fast_ttfb,
    avg_ttfb,
    slow_ttfb

  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date IN ('2023-07-01', '2024-07-01', '2025-07-01') -- noqa: CV09
)

SELECT
  date,
  device,
  rank_grouping AS ranking,

  COUNT(DISTINCT origin) AS total_origins,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_inp, avg_inp, slow_inp) IS NOT FALSE AND
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
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
      IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL
    ))
  ) AS pct_inp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_NI(fast_inp, avg_inp, slow_inp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL
    ))
  ) AS pct_inp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_POOR(fast_inp, avg_inp, slow_inp), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL
    ))
  ) AS pct_inp_poor,

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
  base,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping
GROUP BY
  date,
  device,
  rank_grouping
ORDER BY
  rank_grouping
