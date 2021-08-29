#standardSQL
  # This query will find domains that are payment processors but not marked as ecommerce. Limited to 100 only as a sample
SELECT DISTINCT
  url
FROM
  `httparchive.technologies.2021_07_01_*` ha1
WHERE
  ha1.category = "Payment processors" AND NOT EXISTS (
    SELECT
      url,
      category FROM
      `httparchive.technologies.2021_07_01_*` ha2
    WHERE
      ha1.url = ha2.url AND (ha2.category = 'Ecommerce')
  )
LIMIT
100
