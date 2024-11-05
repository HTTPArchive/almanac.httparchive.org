-- Extract the top 20 registrable domains that set cookies
-- Before running query: edit date and client

SELECT
  NET.REG_DOMAIN(domain) AS regDomain,
  COUNT(DISTINCT NET.HOST(page)) / (SELECT (COUNT(DISTINCT NET.HOST(page))) FROM `httparchive.almanac.cookies`) AS percentWebsites
FROM `httparchive.almanac.cookies`
WHERE
  date = "2024-06-01" AND
  client = "desktop" AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie IS NOT NULL
GROUP BY regDomain
ORDER BY percentWebsites DESC
LIMIT 20
