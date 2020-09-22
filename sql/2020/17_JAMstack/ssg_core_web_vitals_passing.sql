#standardSQL
# Core Web Vitals performance by CMS
CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);


SELECT
  app,
  client,
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
      IS_GOOD(fast_fid, avg_fid, slow_fid) AND
      IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
      IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
      IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AND
      IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_good_cwv
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
    SELECT
      CASE
        WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-github-request)') = 'x-github-request' THEN 'GitHub'
        WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(netlify)') = 'netlify' THEN 'Netlify'
        WHEN _cdn_provider = 'Microsoft Azure' THEN 'Azure'
        WHEN _cdn_provider = 'Vercel' THEN 'Vercel'
        WHEN _cdn_provider = 'Amazon CloudFront' THEN 'AWS'
        WHEN _cdn_provider = 'Akamai' THEN 'Akamai'
        WHEN _cdn_provider = 'Cloudflare' THEN 'Cloudflare'
        ELSE NULL
      END AS CDN,
      _TABLE_SUFFIX as client,
      url,
      app
    FROM
      `httparchive.summary_requests.2020_07_01_*`
    JOIN (
      SELECT
        _TABLE_SUFFIX,
        app,
        url
      FROM
        `httparchive.technologies.2020_07_01_*`
      WHERE
        LOWER(category) = "static site generator" OR
				app = "Next.js"
    )
    USING (url, _TABLE_SUFFIX)
		WHERE firstHtml
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  # The CrUX 202008 dataset is not available until September 8.
  date = '2020-07-01' AND
	CDN IS NOT NULL
GROUP BY
  app,
  client
ORDER BY
  origins DESC
