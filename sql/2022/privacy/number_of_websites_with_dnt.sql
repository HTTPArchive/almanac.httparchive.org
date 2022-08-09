#standardSQL
# Pages that request DNT status

WITH blink AS (
  SELECT DISTINCT
    client,
    url,
    IF(feature = 'NavigatorDoNotTrack', 1, 0) AS dnt_from_blink
  FROM
    `httparchive.blink_features.features`
  WHERE
    yyyymmdd = DATE('2022-06-01')
),
pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    url,
    IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.navigator_doNotTrack')='true', 1, 0) AS dnt_from_page
  FROM
    `httparchive.pages.2022_06_01_*`
)

SELECT
  client,
  SUM(dnt_from_blink) AS number_of_websites_with_dnt_blink_usage,
  SUM(dnt_from_blink) / COUNT(DISTINCT blink_url) AS percentage_of_websites_with_dnt_blink_usage,
  SUM(dnt_from_page) AS number_of_websites_with_dnt_page_usage,
  SUM(dnt_from_page) / COUNT(DISTINCT pages_url) AS percentage_of_websites_with_dnt_page
FROM (
  SELECT
    COALESCE(blink.client, pages.client) AS client,
    blink.url AS blink_url,
    pages.url AS pages_url,
    blink.dnt_from_blink,
    pages.dnt_from_page
  FROM blink
  FULL OUTER JOIN pages
  ON
    blink.client = pages.client AND
    blink.url = pages.url
)
GROUP BY client
