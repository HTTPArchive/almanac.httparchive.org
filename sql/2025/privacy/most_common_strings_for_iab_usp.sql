# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH usp_data AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.iab_usp.privacy_string.uspString') AS uspString,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS pages_total
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
)

SELECT
  client,
  uspString,
  COUNT(DISTINCT page) / ANY_VALUE(pages_total) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM usp_data
GROUP BY
  client,
  uspString
ORDER BY
  pct_pages DESC
LIMIT 100
