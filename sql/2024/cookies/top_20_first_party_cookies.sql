-- Extract the top 20 first party cookies seen across websites
-- Before running query: edit table name

SELECT
  name,
  COUNT(DISTINCT NET.HOST(page)) / (SELECT (COUNT(DISTINCT NET.HOST(page))) FROM `httparchive.almanac.DATE_CLIENT_RANK_cookies`) AS percentWebsites
FROM `httparchive.almanac.DATE_CLIENT_RANK_cookies`
WHERE
  firstPartyCookie = TRUE
GROUP BY name
ORDER BY percentWebsites DESC
LIMIT 20
