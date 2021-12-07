#standardSQL
# Core Web Vitals performance by CMS
CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);


SELECT
  client,
  app,
  COUNT(DISTINCT origin) AS origins,
  # Origins with good LCP divided by origins with any LCP.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_good_lcp,

  # Origins with good FID divided by origins with any FID.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_good_fid,

  # Origins with good CLS divided by origins with any CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_good_cls,

  # Origins with good LCP, FID, and CLS dividied by origins with any LCP, FID, and CLS.
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
      IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
      (NOT IS_NON_ZERO(fast_fid, avg_fid, slow_fid) OR IS_GOOD(fast_fid, avg_fid, slow_fid)) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_good_cwv
FROM (
  SELECT
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    CONCAT(origin, '/') AS url,
    *
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date = '2021-07-01')
JOIN (
  SELECT
    client,
    page AS url
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01' AND
    firstHtml)
USING
  (client, url)
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js"
  )
USING (client, url)
GROUP BY
  app,
  client
ORDER BY
  origins DESC
