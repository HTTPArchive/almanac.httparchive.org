#lcp per cms
CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

SELECT
  app,
  client,
  COUNT(DISTINCT url) AS origins,
  COUNT(DISTINCT IF(good_lcp, url, NULL)) AS origins_with_good_lcp,
  COUNT(DISTINCT IF(any_lcp, url, NULL)) AS origins_with_any_lcp
FROM (
  SELECT
    CONCAT(origin, '/') AS url,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    IS_NON_ZERO(fast_lcp, avg_lcp, slow_lcp) AS any_lcp,
    IS_GOOD(fast_lcp, avg_lcp, slow_lcp) AS good_lcp
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date = '2021-07-01' AND
    device IN ('dekstop', 'phone')
) JOIN (
  SELECT DISTINCT
    category,
    app,
    url,
    _TABLE_SUFFIX AS client
  FROM
    `httparchive.technologies.2021_07_01_*`
  WHERE
    app IS NOT NULL AND
    category = 'CMS' AND
    app != ''
) USING (url, client)
GROUP BY
  app,
  client
HAVING
  origins >= 1000
ORDER BY
  origins DESC
