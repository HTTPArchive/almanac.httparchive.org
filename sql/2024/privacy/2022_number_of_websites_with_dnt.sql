#standardSQL
# Pages that request DNT status

WITH blink AS (
  SELECT DISTINCT
    client,
    num_urls,
    pct_urls
  FROM
    `httparchive.blink_features.usage`
  WHERE
    yyyymmdd = '20220601' AND
    feature IN ('NavigatorDoNotTrack')
),

pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.navigator_doNotTrack') = 'true', url, NULL)) AS num_urls,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.navigator_doNotTrack') = 'true', url, NULL)) / COUNT(DISTINCT url) AS pct_urls
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY 1
)

SELECT
  COALESCE(blink.client, pages.client) AS client,
  blink.num_urls AS number_of_websites_with_blink_usage,
  blink.pct_urls AS percentage_of_websites_with_blink_usage,
  pages.num_urls AS number_of_websites_with_response_body_usage,
  pages.pct_urls AS percentage_of_websites_with_response_body_usage
FROM
  blink
FULL OUTER JOIN pages
ON
  blink.client = pages.client
