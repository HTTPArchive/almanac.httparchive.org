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

CREATE TEMPORARY FUNCTION toTimestamp(date_string STRING)
RETURNS INT64 LANGUAGE js AS '''
  try {
    var timestamp = Math.round(new Date(date_string).getTime() / 1000);
    return isNaN(timestamp) ? -1 : timestamp;
  } catch (e) {
    return -1;
  }
''';

INSERT INTO `httparchive.almanac.cookies`
SELECT
  date,
  client,
  page,
  root_page,
  rank,
  CAST(toTimestamp(JSON_VALUE(payload.startedDateTime)) AS STRING) AS startedDateTime,
  ENDS_WITH(NET.HOST(page), '.' || NET.REG_DOMAIN(JSON_VALUE(cookie.domain))) AS firstPartyCookie,
  JSON_VALUE(cookie.name) AS name,
  JSON_VALUE(cookie.domain) AS domain,
  JSON_VALUE(cookie.path) AS path,
  JSON_VALUE(cookie.expires) AS expires,
  JSON_VALUE(cookie.size) AS size,
  JSON_VALUE(cookie.httpOnly) AS httpOnly,
  JSON_VALUE(cookie.secure) AS secure,
  JSON_VALUE(cookie.session) AS session,
  JSON_VALUE(cookie.sameSite) AS sameSite,
  JSON_VALUE(cookie.sameParty) AS sameParty,
  NULLIF(TO_JSON_STRING(cookie.partitionKey), 'null') AS partitionKey,
  NULLIF(TO_JSON_STRING(cookie.partitionKeyOpaque), 'null') AS partitionKeyOpaque
FROM
  `httparchive.crawl.pages`,
  UNNEST(JSON_EXTRACT_ARRAY(custom_metrics.cookies)) AS cookie
WHERE
  date = '2025-07-01'
