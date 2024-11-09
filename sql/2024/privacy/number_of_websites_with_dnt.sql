# Pages that request DNT status

WITH blink AS (
  SELECT DISTINCT
    client,
    num_urls,
    pct_urls
  FROM `httparchive.blink_features.usage`
  WHERE
    yyyymmdd = '20240601' AND
    feature IN ('NavigatorDoNotTrack')
),

pages AS (
  SELECT
    client,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_doNotTrack') = 'true', page, NULL)) AS num_urls,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_doNotTrack') = 'true', page, NULL)) / COUNT(DISTINCT page) AS pct_urls
  FROM `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE
  GROUP BY client
)

SELECT
  COALESCE(blink.client, pages.client) AS client,
  blink.num_urls AS number_of_pages_usage_per_blink,
  blink.pct_urls AS pct_of_websites_usage_per_blink,
  pages.num_urls AS number_of_pages_usage_per_custom_metric,
  pages.pct_urls AS pct_of_websites_usage_per_custom_metric
FROM blink
FULL OUTER JOIN pages
ON blink.client = pages.client
