-- Extract the top 20 first party cookies seen across websites that are
-- partitioned. Note: it is a bit weird that 1st party cookies would also be
-- partitioned, as CHIPS is meant for a 3rd party context...
-- Before running query: edit table name

SELECT
  name,
  COUNT(DISTINCT NET.HOST(page)) / (SELECT (COUNT(DISTINCT NET.HOST(page))) FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`) AS percentWebsites
FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`
WHERE
  firstPartyCookie = TRUE AND
  partitionKey IS NOT NULL
GROUP BY name
ORDER BY percentWebsites DESC
LIMIT 20