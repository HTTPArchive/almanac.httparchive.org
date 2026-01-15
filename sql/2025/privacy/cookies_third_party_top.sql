FROM `httparchive.crawl.pages`
|> WHERE date = '2025-07-01' -- AND rank = 1000
|> EXTEND COUNT(DISTINCT NET.HOST(root_page)) OVER (PARTITION BY client) AS total_domains
|> JOIN UNNEST(JSON_QUERY_ARRAY(custom_metrics.cookies)) AS cookie
|> EXTEND
NET.HOST(root_page) AS firstparty_domain,
NET.HOST(SAFE.STRING(cookie.domain)) AS cookie_domain,
NET.HOST(SAFE.STRING(cookie.domain)) || ' / ' || SAFE.STRING(cookie.name) AS cookie_details
|> WHERE NOT ENDS_WITH('.' || firstparty_domain, '.' || cookie_domain)
|> AGGREGATE
COUNT(DISTINCT firstparty_domain) AS domain_count,
COUNT(DISTINCT firstparty_domain) / ANY_VALUE(total_domains) AS pct_domains
GROUP BY client, cookie_details
|> PIVOT (
  ANY_VALUE(domain_count) AS domain_count,
  ANY_VALUE(pct_domains) AS pct_domains
  FOR client IN ('desktop', 'mobile')
)
|> RENAME
pct_domains_mobile AS mobile,
pct_domains_desktop AS desktop
|> ORDER BY COALESCE(domain_count_mobile, 0) + COALESCE(domain_count_desktop, 0) DESC
|> LIMIT 1000
