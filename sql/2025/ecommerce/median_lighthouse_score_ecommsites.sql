WITH technologies AS (
  SELECT
    client,
    page,
    category,
    technology,
    rank,
    lighthouse,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_websites
  FROM `httparchive.all.pages`,
    UNNEST(technologies) AS tech,
    UNNEST(categories) AS category
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  rank,
  technology,
  ARRAY_AGG(DISTINCT category) AS categories,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.performance.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_performance,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.accessibility.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.seo.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_seo,
  APPROX_QUANTILES(CAST(JSON_EXTRACT_SCALAR(lighthouse, '$.categories.best-practices.score') AS NUMERIC), 1000)[OFFSET(500)] AS median_best_practices,
  ANY_VALUE(total_websites) AS total_websites,
  COUNT(DISTINCT page) AS number_of_websites,
  COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS percent_of_websites
FROM technologies
WHERE
  category = 'Ecommerce' AND
  (
    technology != 'Cart Functionality' AND
    technology != 'Google Analytics Enhanced eCommerce'
  )
GROUP BY
  client,
  rank,
  technology
ORDER BY
  client,
  number_of_websites DESC
