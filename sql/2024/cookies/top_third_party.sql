-- Extract top 100 third party cookies for each client

WITH top_cookies AS (
  SELECT
    client,
    name,
    domain,
    COUNT(DISTINCT page) AS distinct_page_count
  FROM `httparchive.almanac.2024-06-01_top10k_cookies`
  WHERE
    is_first_party = FALSE
  GROUP BY client, name, domain
),
top_numbered_cookies AS (
  SELECT
    client,
    name,
    domain,
    distinct_page_count,
    ROW_NUMBER() OVER (PARTITION BY client ORDER BY distinct_page_count DESC) AS row_num
  FROM top_cookies
)

SELECT
  client,
  name,
  domain,
  distinct_page_count,
  row_num
FROM top_numbered_cookies
WHERE row_num <= 100
ORDER BY client, row_num
