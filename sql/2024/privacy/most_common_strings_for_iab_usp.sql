#standardSQL
# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS pages_total
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01'
  GROUP BY client
), usp_data AS (
  SELECT
    client,
    page,
    JSON_VALUE(custom_metrics, '$.privacy.iab_usp.privacy_string.uspString') AS uspString
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    JSON_VALUE(custom_metrics, '$.privacy.iab_usp.privacy_string.uspString') IS NOT NULL
)

SELECT
  client,
  uspString,
  COUNT(DISTINCT page) AS pages_with_usp,
  ANY_VALUE(pages_total) AS pages_total,
  COUNT(DISTINCT page) / ANY_VALUE(pages_total) AS pages_pct
FROM usp_data
JOIN totals
USING (client)
GROUP BY
  client,
  uspString
ORDER BY
  client,
  pages_pct DESC
LIMIT 100
