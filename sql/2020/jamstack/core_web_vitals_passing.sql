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
  CDN,
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
FROM (
  SELECT
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    CONCAT(origin, '/') AS url,
    *
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date = '2020-08-01')
JOIN (
  SELECT
    CASE
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-github-request)') = 'x-github-request' THEN 'GitHub'
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(netlify)') = 'netlify' THEN 'Netlify'
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-nf-request-id)') IS NOT NULL THEN 'Netlify'
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-vercel-id)') IS NOT NULL THEN 'Vercel'
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-amz-cf-id)') IS NOT NULL THEN 'AWS'
      WHEN REGEXP_EXTRACT(LOWER(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server)), '(x-azure-ref)') IS NOT NULL THEN 'Azure'
      WHEN _cdn_provider = 'Microsoft Azure' THEN 'Azure'
      WHEN _cdn_provider = 'DigitalOcean Spaces CDN' THEN 'DigitalOcean'
      WHEN _cdn_provider = 'Vercel' THEN 'Vercel'
      WHEN _cdn_provider = 'Amazon CloudFront' THEN 'AWS'
      WHEN _cdn_provider = 'Akamai' THEN 'Akamai'
      WHEN _cdn_provider = 'Cloudflare' THEN 'Cloudflare'
      ELSE NULL
    END AS CDN,
    client,
    page AS url
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2020-08-01' AND
    firstHtml)
USING
  (client, url)
JOIN (
  SELECT
    _TABLE_SUFFIX AS client,
    app,
    url
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
    LOWER(category) = "static site generator" OR
    app = "Next.js" OR
    app = "Nuxt.js" OR
    app = "Docusaurus"
  )
USING (client, url)
WHERE
  CDN IS NOT NULL
GROUP BY
  app,
  CDN,
  client
ORDER BY
  origins DESC
