-- Prevalence of cookies type and attributes per rank grouping
-- Before running query: edit date and client

SELECT
  rank_grouping,
  SUM(IF(firstPartyCookie = TRUE, 1, 0)) / COUNT(0) AS firstParty,
  SUM(IF(firstPartyCookie = FALSE, 1, 0)) / COUNT(0) AS thirdParty,
  SUM(IF(httpOnly = 'true', 1, 0)) / COUNT(0) AS httpOnly,
  SUM(IF(secure = 'true', 1, 0)) / COUNT(0) AS secure,
  SUM(IF(session = 'true', 1, 0)) / COUNT(0) AS session,
  SUM(IF(sameParty = 'true', 1, 0)) / COUNT(0) AS sameParty,
  SUM(IF(sameSite = 'Lax', 1, 0)) / COUNT(0) AS sameSiteLax,
  SUM(IF(sameSite = 'None', 1, 0)) / COUNT(0) AS sameSiteNone,
  SUM(IF(sameSite = 'Strict', 1, 0)) / COUNT(0) AS sameSiteStrict,
  SUM(IF(sameSite IS NULL, 1, 0)) / COUNT(0) AS sameSiteNull,
  SUM(IF(partitionKey IS NOT NULL, 1, 0)) / COUNT(0) AS partitionKey,
  SUM(IF(partitionKeyOpaque IS NOT NULL, 1, 0)) / COUNT(0) AS partitionKeyOpaque
FROM `httparchive.almanac.cookies`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping AND
  date = '2025-07-01' AND
  client = 'desktop' AND
  firstPartyCookie IS NOT NULL -- just in case
GROUP BY
  rank_grouping
ORDER BY
  rank_grouping;


SELECT
  rank_grouping,
  ROUND(SUM(IF(firstPartyCookie = TRUE, 1, 0)) / COUNT(0) * 100, 2) AS firstParty,
  ROUND(SUM(IF(firstPartyCookie = FALSE, 1, 0)) / COUNT(0) * 100, 2) AS thirdParty,
  ROUND(SUM(IF(httpOnly = 'true', 1, 0)) / COUNT(0) * 100, 2) AS httpOnly,
  ROUND(SUM(IF(secure = 'true', 1, 0)) / COUNT(0) * 100, 2) AS secure,
  ROUND(SUM(IF(session = 'true', 1, 0)) / COUNT(0) * 100, 2) AS session,
  ROUND(SUM(IF(sameParty = 'true', 1, 0)) / COUNT(0) * 100, 2) AS sameParty,
  ROUND(SUM(IF(sameSite = 'Lax', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteLax,
  ROUND(SUM(IF(sameSite = 'None', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteNone,
  ROUND(SUM(IF(sameSite = 'Strict', 1, 0)) / COUNT(0) * 100, 2) AS sameSiteStrict,
  ROUND(SUM(IF(sameSite IS NULL, 1, 0)) / COUNT(0) * 100, 2) AS sameSiteNull,
  ROUND(SUM(IF(partitionKey IS NOT NULL, 1, 0)) / COUNT(0) * 100, 2) AS partitionKey,
  ROUND(SUM(IF(partitionKeyOpaque IS NOT NULL, 1, 0)) / COUNT(0) * 100, 2) AS partitionKeyOpaque
FROM `httparchive.almanac.cookies`,
  UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
WHERE
  rank <= rank_grouping AND
  date = '2025-07-01' AND
  client = 'mobile' AND
  firstPartyCookie IS NOT NULL -- just in case
GROUP BY
  rank_grouping
ORDER BY
  rank_grouping;
