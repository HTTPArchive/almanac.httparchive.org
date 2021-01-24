#standardSQL
# Core Web Vitals distribution by Ecommerce vendor
#
# Note that this is an unweighted average of all sites per Ecommerce vendor.
# Performance of sites with millions of visitors as weighted the same as small sites.
SELECT
  date,
  avg(desktopDensity) AS desktopDensity,
  avg(phoneDensity) AS phoneDensity,
  avg(tabletDensity) AS tabletDensity  
FROM
  `chrome-ux-report.materialized.metrics_summary`
JOIN (
  SELECT DISTINCT
    url
  FROM
    `httparchive.technologies.2020_08_01_*`
  WHERE
  category = 'Ecommerce')
ON
  CONCAT(origin, '/') = url
and date >= '2019-01-01'   
GROUP BY
  date
ORDER BY
  date DESC
