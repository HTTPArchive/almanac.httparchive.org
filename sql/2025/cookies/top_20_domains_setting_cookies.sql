-- Extract the top 20 registrable domains that set cookies
-- Before running query: edit date and client

SELECT
  NET.REG_DOMAIN(domain) AS regDomain,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'desktop' AND
      rank <= 1000000 AND
      firstPartyCookie IS NOT NULL
  ) AS percentWebsites
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND
  firstPartyCookie IS NOT NULL
GROUP BY regDomain
ORDER BY percentWebsites DESC
LIMIT 20;

SELECT
  NET.REG_DOMAIN(domain) AS regDomain,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'mobile' AND
      rank <= 1000000 AND
      firstPartyCookie IS NOT NULL
  ) AS percentWebsites
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND
  firstPartyCookie IS NOT NULL
GROUP BY regDomain
ORDER BY percentWebsites DESC
LIMIT 20;
