-- Create an intermediate table containing all cookies that were set during the
-- <DATE> crawl on <CLIENT> when visiting sites of rank <= <RANK>. This table
-- can then be reused in consecutive queries without having to reextract the
-- data every time
-- Export the table as httparchive.almanac.DATE_CLIENT_RANK_cookies

WITH intermediate_cookie AS (
  SELECT
    page,
    rank,
    JSON_VALUE(summary, '$.startedDateTime') AS startedDateTime,
    cookie
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(custom_metrics, '$.cookies')) AS cookie
  WHERE
    date = '2024-06-01' AND
    client = 'desktop' AND
    rank <= 1000000
)

SELECT
  page,
  rank,
  startedDateTime,
  ENDS_WITH(NET.HOST(page), NET.REG_DOMAIN(JSON_VALUE(cookie, '$.domain'))) AS firstPartyCookie,
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