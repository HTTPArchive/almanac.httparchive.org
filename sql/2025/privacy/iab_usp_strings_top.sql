-- noqa: disable=PRS
-- Counts of US Privacy String values for websites using IAB US Privacy Framework
-- cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
  GROUP BY client
)

FROM `httparchive.crawl.pages`
|> WHERE date = '2025-07-01'
|> EXTEND UPPER(SAFE.STRING(custom_metrics.privacy.iab_usp.privacy_string.uspString)) AS uspString
|> WHERE uspString IS NOT NULL
|> AGGREGATE COUNT(DISTINCT root_page) AS websites_count GROUP BY client, uspString
|> JOIN base_totals USING (client)
|> EXTEND websites_count / total_websites AS pct_websites
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(websites_count) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY COALESCE(websites_count_desktop, 0) + COALESCE(websites_count_mobile, 0) DESC
