# Percent of pages that deploy at least one tracker from each tracker category
WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM httparchive.almanac.whotracksme
  WHERE date = '2024-06-01'
),
totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_websites
  FROM httparchive.crawl.requests
  WHERE
    date = '2024-06-01'
  GROUP BY client
),
tracker_categories AS (
  SELECT
    client,
    category,
    page
  FROM httparchive.crawl.requests
  JOIN whotracksme
  ON (
    NET.HOST(url) = domain OR
    ENDS_WITH(NET.HOST(url), CONCAT('.', domain))
    )
  WHERE
    date = '2024-06-01' AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url) -- third party
),
aggregated AS (
  SELECT
    client,
    category,
    COUNT(DISTINCT page) AS number_of_websites
  FROM tracker_categories
  GROUP BY
    client,
    category
  UNION ALL
  SELECT
    client,
    'any' AS category,
    COUNT(DISTINCT page) AS number_of_websites
  FROM tracker_categories
  GROUP BY
    client
)

SELECT
  client,
  category,
  number_of_websites,
  total_websites,
  number_of_websites / total_websites AS pct_websites
FROM aggregated
JOIN totals
USING (client)
ORDER BY number_of_websites DESC
