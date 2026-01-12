-- Extract largest cookies being set
-- Before running query: edit date and client

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND
  firstPartyCookie = TRUE
ORDER BY sizeCookie DESC
LIMIT 10;

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND
  firstPartyCookie = FALSE
ORDER BY sizeCookie DESC
LIMIT 10;

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND
  firstPartyCookie = TRUE
ORDER BY sizeCookie DESC
LIMIT 10;

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.cookies`
WHERE
  date = '2025-07-01' AND
  client = 'mobile' AND
  rank <= 1000000 AND
  firstPartyCookie = FALSE
ORDER BY sizeCookie DESC
LIMIT 10;
