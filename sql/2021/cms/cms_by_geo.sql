#standardSQL
# CMS popularity per geo
WITH geo_summary AS (
  SELECT
    *,
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202107
UNION ALL
  SELECT
    *,
    'ALL' AS geo
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202107)

SELECT
  *
FROM (
  SELECT
    client,
    geo,
    cms,
    COUNT(0) AS pages,
    SUM(COUNT(0)) OVER (PARTITION BY client, geo) AS total,
    COUNT(DISTINCT url) / SUM(COUNT(0)) OVER (PARTITION BY client, geo) AS pct
  FROM (
    SELECT
      IF(device = 'desktop', 'desktop', 'mobile') AS client,
      geo,
      CONCAT(origin, '/') AS url,
    FROM
      geo_summary
  ) JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      category,
      app AS cms,
      url
    FROM
      `httparchive.technologies.2021_07_01_*`
    WHERE
      app IS NOT NULL AND
      category = 'CMS' AND
      app != ''
  ) USING (client, url)
  GROUP BY
    client,
    geo,
    cms)
WHERE
  pages > 1000
ORDER BY
  pct DESC
