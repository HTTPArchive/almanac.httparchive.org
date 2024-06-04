#standardSQL
# Core Web Vitals distribution by SSG
#
# Note that this is an unweighted average of all sites per SSG.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  CDN,
  COUNT(DISTINCT origin) AS origins,
  SUM(fast_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS good_lcp,
  SUM(avg_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS ni_lcp,
  SUM(slow_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS poor_lcp,

  SUM(fast_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS good_fid,
  SUM(avg_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS ni_fid,
  SUM(slow_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS poor_fid,

  SUM(small_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS good_cls,
  SUM(medium_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS ni_cls,
  SUM(large_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS poor_cls
FROM (
  SELECT
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    CONCAT(origin, '/') AS url,
    *
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date = '2021-07-01'
)
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
    date = '2021-07-01' AND
    firstHtml
)
USING (client, url)
JOIN (
  SELECT DISTINCT
    _TABLE_SUFFIX AS client,
    app
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = 'static site generator' OR
    app = 'Next.js' OR
    app = 'Nuxt.js'
)
USING (client, url)
WHERE
  CDN IS NOT NULL
GROUP BY
  CDN,
  client
ORDER BY
  origins DESC
