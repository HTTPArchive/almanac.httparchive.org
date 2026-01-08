-- Extract the top 20 first party cookies seen across websites
-- Before running query: edit date and client
SELECT
  name,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'desktop' AND
      rank <= 1000000 AND
      firstPartyCookie = TRUE
  ) AS percentWebsites
FROM
  `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND
  firstPartyCookie = TRUE
GROUP BY
  name
ORDER BY
  percentWebsites DESC
LIMIT
  20;


SELECT
  name,
  COUNT(DISTINCT NET.HOST(page)) / (
    SELECT
      (COUNT(DISTINCT NET.HOST(page)))
    FROM
      `httparchive.almanac.cookies`
    WHERE
      date = '2025-07-01' AND
      client = 'mobile' AND
      rank <= 1000000 AND
      firstPartyCookie = TRUE
  ) AS percentWebsites
FROM
  `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND
  firstPartyCookie = TRUE
GROUP BY
  name
ORDER BY
  percentWebsites DESC
LIMIT
  20;
