# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH pages AS (
  SELECT
    client,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/gpc.json".found') = 'true', page, NULL)) / COUNT(DISTINCT page) AS pct_pages_well_known,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/gpc.json".found') = 'true', page, NULL)) AS number_of_pages_well_known,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_globalPrivacyControl') = 'true', page, NULL)) / COUNT(DISTINCT page) AS pct_pages_js_api,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_globalPrivacyControl') = 'true', page, NULL)) AS number_of_pages_js_api
  FROM `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE
  GROUP BY client
),

headers AS (
  SELECT
    client,
    COUNT(DISTINCT IF(headers.name = 'sec-gpc' AND headers.value = '1', page, NULL)) / COUNT(DISTINCT page) AS pct_pages_headers,
    COUNT(DISTINCT IF(headers.name = 'sec-gpc' AND headers.value = '1', page, NULL)) AS number_of_pages_headers
  FROM `httparchive.all.requests`,
    UNNEST(response_headers) headers
  WHERE
    date = '2025-07-01' AND
    is_root_page = TRUE AND
    is_main_document = TRUE
  GROUP BY client
)

SELECT *
FROM pages
FULL OUTER JOIN headers
USING (client)
