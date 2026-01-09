#standardSQL
# Core Web Vitals distribution by CMS
#
# Note that this is an unweighted average of all sites per CMS.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  client,
  cms,
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
