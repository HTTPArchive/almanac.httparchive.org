WITH technologies AS (
  SELECT
    client,
    page,
    category,
    technology,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_websites
  FROM `httparchive.all.pages`,
    UNNEST(technologies) AS tech,
    UNNEST(categories) AS category
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  technology,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS percent_of_websites,
  COUNT(DISTINCT page) AS number_of_websites,
  ARRAY_AGG(DISTINCT category) AS categories,
  ANY_VALUE(total_websites) AS total_websites
FROM technologies
WHERE
  category IN (
    'Analytics', 'Browser fingerprinting', 'Customer data platform',
    'Geolocation',
    'Advertising', 'Retargeting', 'Personalisation', 'Segmentation',
    'Cookie compliance'
  )
GROUP BY
  client,
  technology
ORDER BY
  client,
  number_of_websites DESC
