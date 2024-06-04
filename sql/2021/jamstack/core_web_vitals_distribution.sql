#standardSQL
# Core Web Vitals distribution by SSG
#
# Note that this is an unweighted average of all sites per SSG.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  app,
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
    app,
    url
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    LOWER(category) = 'static site generator' OR
    app = 'Next.js' OR
    app = 'Nuxt.js'
)
USING (client, url)
GROUP BY
  app,
  client
ORDER BY
  origins DESC
