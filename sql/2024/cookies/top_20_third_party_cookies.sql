-- Extract the top 20 first party cookies seen across websites
-- Before running query: edit table name

SELECT
  name,
  domain,
  COUNT(DISTINCT NET.HOST(page)) / (SELECT (COUNT(DISTINCT NET.HOST(page))) FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`) AS percentWebsites
FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`
WHERE
  firstPartyCookie = FALSE
GROUP BY name, domain
ORDER BY percentWebsites DESC
LIMIT 20