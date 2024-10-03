-- Extract the top 20 registrable domains that set cookies
-- Before running query: edit table name

SELECT
  NET.REG_DOMAIN(domain) AS regDomain,
  COUNT(DISTINCT NET.HOST(page)) / (SELECT (COUNT(DISTINCT NET.HOST(page))) FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`) AS percentWebsites
FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`
WHERE
  firstPartyCookie IS NOT NULL
GROUP BY regDomain
ORDER BY percentWebsites DESC
LIMIT 20