#standardSQL
# Top A/B Testing used in Ecommerce sites
WITH category AS (
  SELECT
    client,
    page,

    technology
  FROM `httparchive.sample_data.pages_10k`,
    UNNEST(technologies) AS tech,
    UNNEST(categories) AS category
  WHERE
    date = '2024-09-01'
    AND is_root_page = TRUE
    AND category = 'Cookie compliance'
),
ecommerce_data AS (
  SELECT
    client,
    page,
    rank,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_websites
  FROM `httparchive.sample_data.pages_10k`,
    UNNEST(technologies) AS tech,
    UNNEST(categories) AS category
  WHERE
    date = '2024-09-01'
    AND is_root_page = TRUE
    AND category = 'Ecommerce'
    AND 
      (
    tech.technology != 'Cart Functionality' AND
    tech.technology != 'Google Analytics Enhanced eCommerce'
  )
  GROUP BY client, page, rank
)
-- join the first query with the second query (ecommerce_data)
SELECT
  c.client,
  c.technology,
  COUNT(c.page) AS page_count,
  MIN(e.total_websites) AS total_ecom_websites,
  COUNT(c.page) / MIN(e.total_websites) AS pct_of_ecom_websites,

FROM category c
JOIN ecommerce_data e
  ON c.client = e.client
  AND c.page = e.page
GROUP BY c.client, c.technology
