#standardSQL
SELECT
  COUNT(DISTINCT origin) AS n,
  ROUND(SUM(IF(ttfb.start < 200, ttfb.density, 0)) / SUM(ttfb.density), 4) AS fastTTFB,
  ROUND(SUM(IF(ttfb.start >= 200 AND ttfb.start < 1000, ttfb.density, 0)) / SUM(ttfb.density), 4) AS avgTTFB,
  ROUND(SUM(IF(ttfb.start >= 1000, ttfb.density, 0)) / SUM(ttfb.density), 4) AS slowTTFB,
  origin,
  app,
  client,
  CDN
FROM
  `chrome-ux-report.all.202007`,
  UNNEST(experimental.time_to_first_byte.histogram.bin) AS ttfb
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
        category, 
        url
      FROM 
        `httparchive.technologies.2020_07_01_*`
      WHERE 
        LOWER(category) = "static site generator"
    )
    USING (url, _TABLE_SUFFIX)
)
ON
  client = IF(form_factor.name = 'desktop', 'desktop', 'mobile') AND CONCAT(origin, '/') = url
WHERE
  CDN IS NOT NULL
GROUP BY
  CDN,
  app,
  client,
  origin
ORDER BY
  n DESC
