#standardSQL
# All CMS popularity per geo
# cms_adoption_by_geo.sql

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
      CONCAT(origin, '/') AS page
    FROM
      geo_summary
  )
  JOIN (
    SELECT
      client,
      page
    FROM
      `httparchive.all.pages`,
      UNNEST(technologies) AS technologies,
      UNNEST(technologies.categories) AS cats
    WHERE
      date = '2024-06-01' AND
      cats = 'CMS' AND
      is_root_page
  )
  USING (client, page)
  GROUP BY
    client,
    geo
)
WHERE
  pages > 1000
ORDER BY
  pages DESC
