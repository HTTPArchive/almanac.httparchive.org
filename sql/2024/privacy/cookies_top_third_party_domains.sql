WITH pages AS (
  SELECT
    page,
    client,
    root_page,
    custom_metrics,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01'
), cookies AS (
  SELECT
    client,
    page,
    cookie,
    NET.HOST(JSON_VALUE(cookie, '$.domain')) AS cookie_host,
    NET.HOST(root_page) AS firstparty_host,
    total_pages
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(custom_metrics, '$.cookies')) AS cookie
)

SELECT
  client,
  cookie_host,
  COUNT(DISTINCT page) AS page_count,
  COUNT(DISTINCT page) / any_value(total_pages) AS pct_pages
FROM cookies
WHERE firstparty_host NOT LIKE '%' || cookie_host
GROUP BY
  client,
  cookie_host
ORDER BY
  page_count DESC,
  client
LIMIT 500
