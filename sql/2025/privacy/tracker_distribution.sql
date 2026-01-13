-- noqa: disable=PRS
-- Number of websites that deploy a certain number of trackers

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
  --AND rank = 1000
  GROUP BY client
),

whotracksme AS (
  SELECT
    NET.HOST(domain) AS domain,
    tracker
  FROM `httparchive.almanac.whotracksme`
  WHERE date = '2025-07-01'
    AND category IN ('advertising', 'pornvertising', 'site_analytics', 'social_media')
),

tracker_counts AS (
  SELECT
    client,
    root_page,
    COUNT(DISTINCT tracker) AS number_of_trackers
  FROM `httparchive.crawl.requests`
  LEFT JOIN whotracksme
  ON
    NET.HOST(url) = domain OR
    ENDS_WITH(NET.HOST(url), CONCAT('.', domain))
  WHERE
    date = '2025-07-01'
    --AND rank = 1000
    AND url NOT IN ('https://android.clients.google.com/checkin', 'https://android.clients.google.com/c2dm/register3')
  GROUP BY
    client,
    root_page
)

FROM tracker_counts
|> AGGREGATE COUNT(DISTINCT root_page) AS number_of_websites GROUP BY client, number_of_trackers
|> EXTEND SUM(number_of_websites) OVER (PARTITION BY client ORDER BY number_of_trackers DESC) AS ccdf_websites
|> JOIN base_totals USING (client)
|> EXTEND ccdf_websites / total_websites AS ccdf
|> DROP total_websites, number_of_websites
|> PIVOT(
  ANY_VALUE(ccdf_websites) AS websites_count,
  ANY_VALUE(ccdf) AS ccdf
  FOR client IN ('desktop', 'mobile')
)
|> RENAME ccdf_mobile AS mobile, ccdf_desktop AS desktop
|> ORDER BY number_of_trackers
