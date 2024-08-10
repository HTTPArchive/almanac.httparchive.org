-- Most common cookie names, by number of domains on which they appear. Goal is to identify common trackers that use first-party cookies across sites.

with pages as (
  select client, root_page, custom_metrics from `httparchive.all.pages` -- TABLESAMPLE SYSTEM (0.00001 PERCENT)
    WHERE date = "2024-06-01"
),
cookies as (
select client, cookie, net.host(JSON_VALUE(cookie, "$.domain")) as cookie_host, net.host(root_page) as firstparty_host from pages, UNNEST(JSON_QUERY_ARRAY(custom_metrics, "$.cookies")) cookie
)
select client, count(distinct firstparty_host) as domain_count, JSON_VALUE(cookie, "$.name") as cookie_name from cookies where firstparty_host like "%" || cookie_host group by client, cookie_name order by domain_count desc, client desc limit 500