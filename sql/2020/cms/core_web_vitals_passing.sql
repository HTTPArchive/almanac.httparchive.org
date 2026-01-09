#standardSQL
# Core Web Vitals performance by CMS
CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);


SELECT
  client,
  cms,
  COUNT(DISTINCT origin) AS origins,
  # Origins with good LCP divided by origins with any LCP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))
  ) AS pct_good_lcp,

  # Origins with good FID divided by origins with any FID.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))
  ) AS pct_good_fid,

  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))
  ) AS pct_good_cls,

  # Origins with good LCP, FID, and CLS dividied by origins with any LCP, FID, and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      IS_GOOD(fast_fid, avg_fid, slow_fid) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL
    )),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL
    ))
  ) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    app AS cms
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    category = 'CMS'
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  # The CrUX 202008 dataset is not available until September 8.
  date = '2020-07-01' -- noqa: CV09
GROUP BY
  client,
  cms
ORDER BY
  origins DESC
