#standardSQL
# shipping popularity per geo
# top_shipping_by_geo.sql
WITH geo_summary AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    CONCAT(origin, '/') AS root_page,
    COUNT(DISTINCT origin) OVER (PARTITION BY country_code, IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202507
  UNION ALL
  SELECT
    'ALL' AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    CONCAT(origin, '/') AS root_page,
    COUNT(DISTINCT origin) OVER (PARTITION BY IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.device_summary`
  WHERE
    yyyymm = 202507
)

SELECT
  client,
  geo,
  shipping,
  COUNT(DISTINCT root_page) AS sites,
  ANY_VALUE(total) AS total,
  COUNT(DISTINCT root_page) / ANY_VALUE(total) AS pct
FROM
  geo_summary
JOIN (
  SELECT DISTINCT
    client,
    cats,
    technologies.technology AS shipping,
    page,
    root_page
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS technologies,
    UNNEST(technologies.categories) AS cats
  WHERE
    technologies.technology IS NOT NULL AND
    cats = 'Shipping carriers' AND
    technologies.technology != '' AND
    date = '2025-07-01'
) USING (client, root_page)
GROUP BY
  client,
  geo,
  shipping
HAVING
  sites > 1000
ORDER BY
  sites DESC
