-- Extract to the `httparchive.almanac.cookies `table the cookies that were set
-- during the <DATE> crawl on <CLIENT>. Data in this table can then be queried
-- more efficiently in consecutive queries without having to reextract it every
-- time


-- Code used by @tunetheweb to create the table
-- see https://github.com/HTTPArchive/almanac.httparchive.org/pull/3741#discussion_r1823153262

-- CREATE TABLE `httparchive.almanac.cookies`
-- (
--   date DATE,
--   client STRING,
--   page STRING,
--   root_page STRING,
--   rank INTEGER,
--   startedDateTime STRING,
--   firstPartyCookie BOOL,
--   name STRING,
--   domain STRING,
--   path STRING,
--   expires STRING,
--   size STRING,
--   httpOnly STRING,
--   secure STRING,
--   session STRING,
--   sameSite STRING,
--   sameParty STRING,
--   partitionKey STRING,
--   partitionKeyOpaque STRING
-- )
-- PARTITION BY date
-- CLUSTER BY
--   client, rank, page
-- AS
-- ...


INSERT INTO `httparchive.almanac.cookies`
WITH intermediate_cookie AS (
  SELECT
    date,
    client,
    page,
    root_page,
    rank,
    JSON_VALUE(summary, '$.startedDateTime') AS startedDateTime,
    cookie
  FROM
    `httparchive.all.pages`,
    UNNEST(JSON_EXTRACT_ARRAY(custom_metrics, '$.cookies')) AS cookie
  WHERE
    date = '2024-06-01'
)

SELECT
  date,
  client,
  page,
  root_page,
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
