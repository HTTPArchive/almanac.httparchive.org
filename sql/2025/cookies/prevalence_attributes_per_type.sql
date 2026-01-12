-- Prevalence of cookies type and attributes per type of cookie (1st/3rd party)
-- Before running query: edit date and client

SELECT
  firstPartyCookie,
  SUM(IF(httpOnly = 'true', 1, 0)) / COUNT(0) AS httpOnly,
  SUM(IF(secure = 'true', 1, 0)) / COUNT(0) AS secure,
  SUM(IF(session = 'true', 1, 0)) / COUNT(0) AS session,
  SUM(IF(sameParty = 'true', 1, 0)) / COUNT(0) AS sameParty,
  SUM(IF(sameSite = 'Lax', 1, 0)) / COUNT(0) AS sameSiteLax,
  SUM(IF(sameSite = 'None', 1, 0)) / COUNT(0) AS sameSiteNone,
  SUM(IF(sameSite = 'Strict', 1, 0)) / COUNT(0) AS sameSiteStrict,
  SUM(IF(sameSite IS NULL, 1, 0)) / COUNT(0) AS sameSiteNull,
  SUM(IF(partitionKey IS NOT NULL, 1, 0)) / COUNT(0) AS partitionKey,
  SUM(IF(partitionKeyOpaque IS NOT NULL, 1, 0)) / COUNT(0) AS partitionKeyOpaque,
  SUM(IF(STARTS_WITH(name, '__Host-'), 1, 0)) / COUNT(0) AS hostPrefix,
  SUM(IF(STARTS_WITH(name, '__Secure-'), 1, 0)) / COUNT(0) AS securePrefix
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie IS NOT NULL -- just in case
GROUP BY
  firstPartyCookie;

SELECT
  firstPartyCookie,
  ROUND(SUM(IF(httpOnly = 'true', 1, 0)) / COUNT(0) * 100, 2) AS httpOnly,
  ROUND(SUM(IF(secure = 'true', 1, 0)) / COUNT(0) * 100, 2) AS secure,
  ROUND(SUM(IF(session = 'true', 1, 0)) / COUNT(0) * 100, 2) AS session,
  ROUND(SUM(IF(sameParty = 'true', 1, 0)) / COUNT(0) * 100, 2) AS sameParty,
  ROUND(SUM(IF(sameSite = 'Lax', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteLax,
  ROUND(SUM(IF(sameSite = 'None', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteNone,
  ROUND(SUM(IF(sameSite = 'Strict', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteStrict,
  ROUND(SUM(IF(sameSite IS NULL, 1, 0)) / COUNT(0) * 100, 2) AS sameSiteNull,
  ROUND(SUM(IF(partitionKey IS NOT NULL, 1, 0)) / COUNT(0) * 100, 2) AS partitionKey,
  ROUND(SUM(IF(partitionKeyOpaque IS NOT NULL, 1, 0)) / COUNT(0) * 100, 2) AS partitionKeyOpaque,
  ROUND(SUM(IF(STARTS_WITH(name, '__Host-'), 1, 0)) / COUNT(0) * 100, 2) AS hostPrefix,
  ROUND(SUM(IF(STARTS_WITH(name, '__Secure-'), 1, 0)) / COUNT(0) * 100, 2) AS securePrefix
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie IS NOT NULL -- just in case
GROUP BY
  firstPartyCookie;
