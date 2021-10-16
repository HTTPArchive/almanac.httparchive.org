#fid per cms per geo
CREATE TEMP FUNCTION IS_GOOD(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good / (good + needs_improvement + poor) >= 0.75
);

CREATE TEMP FUNCTION IS_NON_ZERO(good FLOAT64, needs_improvement FLOAT64, poor FLOAT64) RETURNS BOOL AS (
  good + needs_improvement + poor > 0
);

WITH geo_summary AS (
  SELECT
    *,
    country_code AS geo_code
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202107 AND
    device IN ('desktop', 'phone')
  UNION ALL
  SELECT
    *,
    'ALL' AS geo_code
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202107 AND
    device IN ('desktop', 'phone')
)

SELECT
  date,
  ARRAY_TO_STRING(ARRAY_AGG(DISTINCT category IGNORE NULLS ORDER BY category), ', ') AS categories,
  geo_code,
  app,
  client,
  COUNT(DISTINCT url) AS origins,
  COUNT(DISTINCT IF(good_fid, url, NULL)) AS origins_with_good_fid,
  COUNT(DISTINCT IF(any_fid, url, NULL)) AS origins_with_any_fid
FROM (
  SELECT
    yyyymm,
    PARSE_DATE('%Y%m', CAST(yyyymm AS STRING)) AS date,
    geo_code,
    CONCAT(origin, '/') AS url,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    IS_NON_ZERO(fast_fid, avg_fid, slow_fid) AS any_fid,
    (IS_GOOD(fast_fid, avg_fid, slow_fid) OR fast_fid IS NULL) AS good_fix
  FROM
    geo_summary
) JOIN (
  SELECT DISTINCT
    CAST('2021-07-01' AS DATE) AS date,
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
) USING (date, url, client)
GROUP BY
  date,
  geo_code,
  app,
  client
HAVING
  origins >= 1000
ORDER BY
  origins DESC
