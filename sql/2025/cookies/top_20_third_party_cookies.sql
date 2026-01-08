-- Extract the top 20 first party cookies seen across websites
-- Before running query: edit date and client

SELECT
  name,
  domain,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'desktop' AND
      rank <= 1000000 AND
      firstPartyCookie = FALSE
  ) AS percentWebsites
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie = FALSE
GROUP BY name, domain
ORDER BY percentWebsites DESC
LIMIT 20;


SELECT
  name,
  domain,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'mobile' AND
      rank <= 1000000 AND
      firstPartyCookie = FALSE
  ) AS percentWebsites
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie = FALSE
GROUP BY name, domain
ORDER BY percentWebsites DESC
LIMIT 20;
