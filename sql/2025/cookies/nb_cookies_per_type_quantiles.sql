-- Extract stats about the nb of cookies
-- Before running query: edit date and client

WITH nb_cookies_per_website AS (
  SELECT
    firstPartyCookie,
    NET.HOST(page) AS pageFirstPartyHost,
    COUNT(DISTINCT CONCAT(name, domain)) AS distinctNbCookies
  FROM `httparchive.almanac.cookies`
  WHERE
    date = '2025-07-01' AND
    client = 'desktop' AND
    rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
    firstPartyCookie IS NOT NULL
  GROUP BY firstPartyCookie, pageFirstPartyHost
)

SELECT
  firstPartyCookie,
  MIN(distinctNbCookies) AS min,
  APPROX_QUANTILES(distinctNbCookies, 100)[OFFSET(25)] AS p25,
  APPROX_QUANTILES(distinctNbCookies, 100)[OFFSET(50)] AS median,
  APPROX_QUANTILES(distinctNbCookies, 100)[OFFSET(75)] AS p75,
  APPROX_QUANTILES(distinctNbCookies, 100)[OFFSET(90)] AS p90,
  APPROX_QUANTILES(distinctNbCookies, 100)[OFFSET(99)] AS p99,
  MAX(distinctNbCookies) AS max
FROM nb_cookies_per_website
GROUP BY firstPartyCookie
