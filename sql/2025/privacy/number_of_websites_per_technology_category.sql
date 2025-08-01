SELECT
  client,
  category,
  COUNT(DISTINCT IF(category = tech_category, page, NULL)) / COUNT(DISTINCT page) AS pct_pages,
  COUNT(DISTINCT IF(category = tech_category, page, NULL)) AS number_of_pages
FROM `httparchive.crawl.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(categories) AS tech_category,
  UNNEST([
    'Analytics', 'Browser fingerprinting', 'Customer data platform',
    'Geolocation',
    'Advertising', 'Retargeting', 'Personalisation', 'Segmentation',
    'Cookie compliance'
  ]) AS category
WHERE
  date = '2025-07-01' AND
  is_root_page = TRUE
GROUP BY
  client,
  category
ORDER BY
  pct_pages DESC
