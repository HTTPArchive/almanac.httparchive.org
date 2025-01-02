# Percent of websites using a fingerprinting library based on wappalyzer category
WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_websites
  FROM httparchive.crawl.pages
  WHERE
    date = '2024-06-01'
  GROUP BY
    client
)

SELECT
  client,
  technology.technology,
  total_websites,
  COUNT(DISTINCT page) AS number_of_websites,
  COUNT(DISTINCT page) / total_websites AS percent_of_websites
FROM httparchive.crawl.pages
JOIN totals USING (client),
  UNNEST(technologies) AS technology,
  UNNEST(technology.categories) AS category
WHERE
  date = '2024-06-01' AND
  category = 'Browser fingerprinting'
GROUP BY
  client,
  total_websites,
  technology
ORDER BY
  client,
  number_of_websites DESC
