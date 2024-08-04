#standardSQL
# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH pages AS (
  SELECT
    client,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/gpc.json".found') = 'true', page, NULL)) AS well_known_pages_count,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.well-known."/.well-known/gpc.json".found') = 'true', page, NULL)) / COUNT(DISTINCT page) AS well_known_pages_pct,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_globalPrivacyControl') = 'true', page, NULL)) AS js_api_pages_count,
    COUNT(DISTINCT IF(JSON_VALUE(custom_metrics, '$.privacy.navigator_globalPrivacyControl') = 'true', page, NULL)) / COUNT(DISTINCT page) AS js_api_pages_pct
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    rank <= 10000
  GROUP BY client
),

headers AS (
  SELECT
    client,
    COUNT(DISTINCT IF(headers.name = 'sec-gpc' AND headers.value = '1', page, NULL)) AS headers_pages_count,
    COUNT(DISTINCT IF(headers.name = 'sec-gpc' AND headers.value = '1', page, NULL)) / COUNT(DISTINCT page) AS headers_pages_pct
  FROM
    `httparchive.all.requests`,
    UNNEST(response_headers) headers
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    is_main_document = TRUE
  GROUP BY client
)

SELECT
  *
FROM pages
FULL OUTER JOIN headers
USING (client)
