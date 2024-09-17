-- Extract top 100 registrable domains setting third party cookies for each client

WITH top_domains AS (
  SELECT
    client,
    NET.REG_DOMAIN(domain) AS registrable_domain,
    COUNT(DISTINCT page) AS distinct_page_count
  FROM `httparchive.almanac.2024-06-01_top100k_cookies`
  WHERE
    is_first_party = FALSE
  GROUP BY client, registrable_domain
),
top_numbered_domains AS (
  SELECT
    client,
    registrable_domain,
    distinct_page_count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY distinct_page_count DESC) AS row_num
  FROM top_domains
)

SELECT
  client,
  registrable_domain,
  distinct_page_count,
  row_num
FROM top_numbered_domains
WHERE row_num <= 100
ORDER BY client, row_num
