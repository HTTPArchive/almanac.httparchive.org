#standardSQL
# Correlation between CWV and preload resource hint

CREATE TEMP FUNCTION IS_GOOD (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NI (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) < 0.75 AND
  poor / (good + needs_improvement + poor) < 0.25
);

CREATE TEMP FUNCTION IS_POOR (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  poor / (good + needs_improvement + poor) >= 0.25
);

CREATE TEMP FUNCTION IS_NON_ZERO (good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

CREATE TEMPORARY FUNCTION getResourceHints(payload STRING)
RETURNS STRUCT<preload INT64, prefetch INT64, preconnect INT64, prerender INT64, `dns-prefetch` INT64, `modulepreload` INT64>
LANGUAGE js AS '''
var hints = ['preload', 'prefetch', 'preconnect', 'prerender', 'dns-prefetch', 'modulepreload'];
try {
  var $ = JSON.parse(payload);
  var almanac = JSON.parse($._almanac);
  return hints.reduce((results, hint) => {
    // Null values are omitted from BigQuery aggregations.
    // This means only pages with at least one hint are considered.
    results[hint] = almanac['link-nodes'].nodes.filter(link => link.rel.toLowerCase() == hint).length || 0;
    return results;
  }, {});
} catch (e) {
  return hints.reduce((results, hint) => {
    results[hint] = 0;
    return results;
  }, {});
}
''' ;


SELECT
  device,
  COUNT(0) AS freq,
  IF(hints.preload >= 20, 20, hints.preload) AS preload,
  SUM(COUNT(0)) OVER (PARTITION BY device) AS total,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_fid, avg_fid, slow_fid) IS NOT FALSE AND
        IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AND
        IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AND
        IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cwv_good,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_lcp, avg_lcp, slow_lcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp), origin, NULL))) AS pct_lcp_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_fid, avg_fid, slow_fid), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fid, avg_fid, slow_fid), origin, NULL))) AS pct_fid_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(small_cls, medium_cls, large_cls), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(small_cls, medium_cls, large_cls), origin, NULL))) AS pct_cls_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_fcp, avg_fcp, slow_fcp), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_fcp, avg_fcp, slow_fcp), origin, NULL))) AS pct_fcp_poor,

  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_GOOD(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_good,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_NI(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_ni,
  SAFE_DIVIDE(
    COUNT(DISTINCT IF(
        IS_POOR(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL)),
    COUNT(DISTINCT IF(
        IS_NON_ZERO(fast_ttfb, avg_ttfb, slow_ttfb), origin, NULL))) AS pct_ttfb_poor
FROM (
  SELECT
    _TABLE_SUFFIX AS device,
    RTRIM(url, "/") AS origin,
    getResourceHints(payload) AS hints
  FROM
    `httparchive.pages.2021_07_01_*`
)
JOIN (
  SELECT
    date,
    origin,
    IF(device = "phone", "mobile", device) AS device,
    rank,

    fast_fid,
    avg_fid,
    slow_fid,

    fast_lcp,
    avg_lcp,
    slow_lcp,

    small_cls,
    medium_cls,
    large_cls,

    fast_fcp,
    avg_fcp,
    slow_fcp,

    fast_ttfb,
    avg_ttfb,
    slow_ttfb
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    device IN ('desktop', 'phone') AND
    date IN ('2021-07-01')
)
USING
  (device, origin)
GROUP BY 
  device,
  preload
ORDER BY 
  device,
  preload
