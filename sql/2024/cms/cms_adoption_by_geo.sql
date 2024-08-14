#standardSQL
# All CMS popularity per geo
WITH geo_summary AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY country_code, IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202406
)

SELECT
  *
FROM (
  SELECT
    client,
    geo,
    COUNT(0) AS pages,
    ANY_VALUE(total) AS total,
    COUNT(0) / ANY_VALUE(total) AS pct
  FROM (
    SELECT DISTINCT
      geo,
      client,
      total,
      CONCAT(origin, '/') AS url
    FROM
      geo_summary
  ) JOIN (
    SELECT DISTINCT
      _TABLE_SUFFIX AS client,
      url
    FROM
      `httparchive.technologies.2024_06_01_*`
    WHERE
      category = 'CMS'
  ) USING (client, url)
  GROUP BY
    client,
    geo)
WHERE
  pages > 1000
ORDER BY
  pages DESC
