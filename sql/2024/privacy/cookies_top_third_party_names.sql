-- Most common cookie names, by number of domains on which they appear. Goal is to identify common trackers that set cookies using many domains.

WITH pages AS (
  SELECT
    client,
    root_page,
    custom_metrics,
    COUNT(DISTINCT net.host(root_page)) OVER (PARTITION BY client) AS total_domains
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01'
),

cookies AS (
  SELECT
    client,
    cookie,
    NET.HOST(JSON_VALUE(cookie, '$.domain')) AS cookie_host,
    NET.HOST(root_page) AS firstparty_host,
    total_domains
  FROM pages,
    UNNEST(JSON_QUERY_ARRAY(custom_metrics, '$.cookies')) AS cookie
)

SELECT
  client,
  COUNT(DISTINCT firstparty_host) AS domain_count,
  COUNT(DISTINCT firstparty_host) / any_value(total_domains) AS pct_domains,
  JSON_VALUE(cookie, '$.name') AS cookie_name
FROM cookies
WHERE firstparty_host NOT LIKE '%' || cookie_host
GROUP BY
  client,
  cookie_name
ORDER BY
  domain_count DESC,
  client DESC
LIMIT 500
