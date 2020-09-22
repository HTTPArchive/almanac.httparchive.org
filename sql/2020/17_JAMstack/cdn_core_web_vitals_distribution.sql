#standardSQL
# Core Web Vitals distribution by CDN
#
# Note that this is an unweighted average of all sites per SSG.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  CDN,
  COUNT(DISTINCT origin) AS origins,
  SUM(fast_lcp) / SUM(fast_lcp + avg_lcp + slow_lcp) AS good_lcp,
  SUM(avg_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS ni_lcp,
  SUM(slow_lcp) / (SUM(fast_lcp) + SUM(avg_lcp) + SUM(slow_lcp)) AS poor_lcp,

  SUM(fast_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS good_fid,
  SUM(avg_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS ni_fid,
  SUM(slow_fid) / (SUM(fast_fid) + SUM(avg_fid) + SUM(slow_fid)) AS poor_fid,

  SUM(small_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS good_cls,
  SUM(medium_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS ni_cls,
  SUM(large_cls) / (SUM(small_cls) + SUM(medium_cls) + SUM(large_cls)) AS poor_cls,
FROM
  `chrome-ux-report.materialized.device_summary`
JOIN (
    SELECT
      CASE
        WHEN REGEXP_CONTAINS(CONCAT(respOtherHeaders, resp_x_powered_by, resp_via, resp_server), '(?i)x-github-request') THEN 'GitHub'
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
      `httparchive.summary_requests.2020_08_01_*`
    JOIN (
      SELECT
        _TABLE_SUFFIX,
        app,
        url
      FROM
        `httparchive.technologies.2020_08_01_*`
      WHERE
        LOWER(category) = "static site generator" OR
				app = "Next.js"
    )
    USING (url, _TABLE_SUFFIX)
)
ON
  CONCAT(origin, '/') = url AND
  IF(device = 'desktop', 'desktop', 'mobile') = client
WHERE
  # The CrUX 202008 dataset is not available until September 8.
  date = '2020-08-01' AND
	CDN IS NOT NULL
GROUP BY
  CDN,
  client
ORDER BY
  origins DESC
