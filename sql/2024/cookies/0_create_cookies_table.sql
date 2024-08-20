-- Create the intermediate cookie table for other queries
-- Extract cookie set when visiting websites of rank <= 10 000 on mobile and desktop
-- Export it as httparchive.almanac.<DATE>_top10k_cookies

WITH intermediate_cookie AS (
  SELECT
    client,
    page,
    root_page,
    NET.HOST(page) AS first_party_host,
    rank,
    cookie
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(custom_metrics, '$.cookies')) AS cookie
  WHERE
    date = '2024-06-01' AND
    rank <= 10000
)

SELECT
  client,
  page,
  root_page,
  first_party_host,
  rank,
  ENDS_WITH(first_party_host, NET.REG_DOMAIN(JSON_VALUE(cookie, '$.domain'))) AS is_first_party,
  JSON_VALUE(cookie, '$.name') AS name,
  JSON_VALUE(cookie, '$.domain') AS domain,
  JSON_VALUE(cookie, '$.path') AS path,
  JSON_VALUE(cookie, '$.expires') AS expires,
  JSON_VALUE(cookie, '$.size') AS size,
  JSON_VALUE(cookie, '$.httpOnly') AS httpOnly,
  JSON_VALUE(cookie, '$.secure') AS secure,
  JSON_VALUE(cookie, '$.session') AS session,
  JSON_VALUE(cookie, '$.sameSite') AS sameSite,
  JSON_VALUE(cookie, '$.sameParty') AS sameParty,
  JSON_VALUE(cookie, '$.partitionKey') AS partitionKey,
  JSON_VALUE(cookie, '$.partitionKeyOpaque') AS partitionKeyOpaque
FROM intermediate_cookie
