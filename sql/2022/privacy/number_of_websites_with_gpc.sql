#standardSQL
# Pages that provide `/.well-known/gpc.json` for Global Privacy Control

WITH pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/gpc.json"'), '$.found') = 'true', url, NULL)) AS well_known_num_urls,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_QUERY(JSON_VALUE(payload, '$._well-known'), '$."/.well-known/gpc.json"'), '$.found') = 'true', url, NULL)) / COUNT(DISTINCT url) AS well_known_pct_urls,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.navigator_globalPrivacyControl') = 'true', url, NULL)) AS pages_num_urls,
    COUNT(DISTINCT IF(JSON_QUERY(JSON_VALUE(payload, '$._privacy'), '$.navigator_globalPrivacyControl') = 'true', url, NULL)) / COUNT(DISTINCT url) AS pages_pct_urls
  FROM
    `httparchive.pages.2022_06_01_*`
  GROUP BY 1
),

headers AS (
  SELECT
    client,
    COUNT(DISTINCT IF(LOWER(JSON_VALUE(headers, '$.name')) = 'sec-gpc' AND JSON_VALUE(headers, '$.value') = '1', page, NULL)) AS headers_num_urls,
    COUNT(DISTINCT IF(LOWER(JSON_VALUE(headers, '$.name')) = 'sec-gpc' AND JSON_VALUE(headers, '$.value') = '1', page, NULL)) / COUNT(DISTINCT page) AS headers_pct_urls
  FROM
    `httparchive.almanac.requests`,
    UNNEST(JSON_QUERY_ARRAY(response_headers)) headers
  WHERE
    date = '2022-06-01' AND
    firstHtml = TRUE
  GROUP BY 1
)

SELECT
  *
FROM pages
FULL OUTER JOIN headers
USING (client)
