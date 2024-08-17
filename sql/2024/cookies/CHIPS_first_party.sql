-- Extract top 100 first party cookies that are partitioned (CHIPS) for each client
-- Note: it is a bit weird that 1st party cookies would also be partitioned, as
-- CHIPS is meant for a 3rd party context...

WITH top_cookies AS (
    SELECT
        client,
        name,
        COUNT(DISTINCT first_party_host) as distinct_first_party_count
    FROM `httparchive.almanac.2024-06-01_top10k_cookies`
    WHERE
        partitionKey IS NOT NULL AND
        is_first_party = TRUE
    GROUP BY client, name
),
top_numbered_cookies AS (
    SELECT
        client,
        name,
        distinct_first_party_count,
        ROW_NUMBER() over (PARTITION BY client ORDER BY distinct_first_party_count DESC) AS row_num
    FROM top_cookies
)

SELECT 
    client,
    name,
    distinct_first_party_count,
    row_num
FROM top_numbered_cookies
WHERE row_num <= 100
ORDER BY client, row_num