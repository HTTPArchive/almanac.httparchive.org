-- Extract top 100 websites that have the most cookies (1st and 3rd) set on them

WITH top_websites AS (
  SELECT
    client,
    first_party_host,
    COUNT(DISTINCT CONCAT(name, domain)) AS distinct_cookie_count
  FROM `httparchive.almanac.2024-06-01_top10k_cookies`
  GROUP BY client, first_party_host
),
top_numbered_websites AS (
  SELECT
    client,
    first_party_host,
    distinct_cookie_count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY distinct_cookie_count DESC) AS row_num
  FROM top_websites
)

SELECT
  client,
  first_party_host,
  distinct_cookie_count,
  row_num
FROM top_numbered_websites
WHERE row_num <= 100
ORDER BY client, row_num
