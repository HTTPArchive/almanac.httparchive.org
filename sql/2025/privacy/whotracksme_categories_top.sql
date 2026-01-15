-- noqa: disable=PRS
-- Percent of websites that deploy at least one tracker from each tracker category

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM httparchive.crawl.pages
  WHERE date = '2025-07-01'
  GROUP BY client
),

whotracksme AS (
  SELECT
    NET.HOST(domain) AS domain,
    category
  FROM httparchive.almanac.whotracksme
  WHERE date = '2025-07-01'
),

tracker_categories AS (
  SELECT
    client,
    category,
    root_page
  FROM httparchive.crawl.requests
  JOIN whotracksme
  ON (
    NET.HOST(url) = domain OR
    ENDS_WITH(NET.HOST(url), CONCAT('.', domain))
  )
  WHERE
    date = '2025-07-01'
    AND url NOT IN ('https://android.clients.google.com/checkin', 'https://android.clients.google.com/c2dm/register3')
),

aggregated AS (
  SELECT
    client,
    category,
    COUNT(DISTINCT root_page) AS number_of_websites
  FROM tracker_categories
  GROUP BY
    client,
    category
  UNION ALL
  SELECT
    client,
    'any' AS category,
    COUNT(DISTINCT root_page) AS number_of_websites
  FROM tracker_categories
  GROUP BY
    client
)

FROM aggregated
|> JOIN base_totals USING (client)
|> EXTEND number_of_websites / total_websites AS pct_websites
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS Mobile, pct_desktop AS Desktop
|> ORDER BY COALESCE(websites_count_desktop, 0) + COALESCE(websites_count_mobile, 0) DESC
