#cls per cms
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
  COUNT(DISTINCT IF(good_cls, url, NULL)) AS origins_with_good_cls,
  COUNT(DISTINCT IF(any_cls, url, NULL)) AS origins_with_any_cls
FROM (
  SELECT
    CONCAT(origin, '/') AS url,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    IS_NON_ZERO(small_cls, medium_cls, large_cls) AS any_cls,
    IS_GOOD(small_cls, medium_cls, large_cls) AS good_cls
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    date = '2021-07-01' AND
    device IN ('dekstop', 'phone')
) JOIN (
  SELECT DISTINCT
    category,
    app,
    _TABLE_SUFFIX AS client,
    url
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
