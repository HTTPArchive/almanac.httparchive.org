#standardSQL
# Core Web Vitals distribution by SSG
#
# Note that this is an unweighted average of all sites per SSG.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  app,
  CDN,
  COUNT(DISTINCT url) AS origins
FROM (
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
    firstHtml)
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
WHERE
  CDN IS NOT NULL
GROUP BY
  CDN,
  app,
  client
ORDER BY
  origins DESC
