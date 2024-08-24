WITH pages AS (
  SELECT page, client, root_page, custom_metrics, count(DISTINCT page) OVER (PARTITION BY client) AS total_pages FROM `httparchive.all.pages`  -- TABLESAMPLE SYSTEM (0.1 PERCENT)
  WHERE date = '2024-06-01'
),
cookies AS (
  SELECT client, page, cookie, net.host(JSON_VALUE(cookie, '$.domain')) AS cookie_host, net.host(root_page) AS firstparty_host, total_pages FROM pages, UNNEST(JSON_QUERY_ARRAY(custom_metrics, '$.cookies')) cookie
)
SELECT client, cookie_host, count(DISTINCT page) AS page_count, count(DISTINCT page) / any_value(total_pages) AS pct_pages FROM cookies WHERE firstparty_host NOT LIKE '%' || cookie_host GROUP BY client, cookie_host ORDER BY page_count DESC, client LIMIT 500
