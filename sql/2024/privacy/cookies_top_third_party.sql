
with pages as (
  select page, client, root_page, custom_metrics from `httparchive.all.pages` -- TABLESAMPLE SYSTEM (0.00001 PERCENT)
    WHERE date = "2024-06-01"
),
cookies as (
select client, page, cookie, net.host(JSON_VALUE(cookie, "$.domain")) as cookie_host, net.host(root_page) as firstparty_host from pages, UNNEST(JSON_QUERY_ARRAY(custom_metrics, "$.cookies")) cookie
)
select client, cookie_host, count(distinct page) as page_count from cookies where firstparty_host not like "%" || cookie_host group by client, cookie_host order by page_count desc, client limit 500