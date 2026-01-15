WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_webpages,
    COUNT(DISTINCT root_page) AS total_websites
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01'
  GROUP BY
    client
)

SELECT
  client,
  technology,
  ARRAY_AGG(DISTINCT category) AS categories,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse.categories.performance.score) AS NUMERIC) * 100, 1000)[OFFSET(500)] AS median_performance,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse.categories.accessibility.score) AS NUMERIC) * 100, 1000)[OFFSET(500)] AS median_accessibility,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse.categories.seo.score) AS NUMERIC) * 100, 1000)[OFFSET(500)] AS median_seo,
  APPROX_QUANTILES(CAST(JSON_VALUE(lighthouse.categories.`best-practices`.score) AS NUMERIC) * 100, 1000)[OFFSET(500)] AS median_best_practices,
  ANY_VALUE(total_websites) AS total_websites,
  COUNT(DISTINCT root_page) AS number_of_websites,
  COUNT(DISTINCT root_page) / ANY_VALUE(total_websites) AS percent_of_websites
FROM
  `httparchive.crawl.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(categories) AS category
INNER JOIN
  totals
USING (client)
WHERE
  date = '2025-07-01' AND
  category = 'Ecommerce' AND
  (
    technology != 'Cart Functionality' AND
    technology != 'Google Analytics Enhanced eCommerce'
  )
GROUP BY
  client,
  technology
ORDER BY
  client,
  number_of_websites DESC
