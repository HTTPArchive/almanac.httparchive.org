CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);
CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);
SELECT
  date,
  device,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))
  ) AS pct_good_lcp,
  # Origins with good FID divided by origins with any FID.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))
  ) AS pct_good_fid,
  # Origins with good INP divided by origins with any INP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_inp, avg_inp, slow_inp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_inp, avg_inp, slow_inp), origin, NULL))
  ) AS pct_good_inp,
  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))
  ) AS pct_good_cls,
  # Origins with good LCP, FID/INP, and CLS dividied by origins with any LCP, and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      (
        (date >= '2024-03-01' AND IS_GOOD(fast_inp, avg_inp, slow_inp) IS NOT FALSE) OR
        (date < '2024-03-01' AND IS_GOOD(fast_fid, avg_fid, slow_fid) IS NOT FALSE)
      ) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
WHERE
  date BETWEEN '2019-11-01' AND '2025-07-01' AND
  device IN ('desktop', 'phone')
GROUP BY
  date,
  device
ORDER BY
  date DESC
