-- Extract the nb of cookies
-- Before running query: edit table name

WITH nb_cookies_per_website AS (
  SELECT
    firstPartyCookie,
    NET.HOST(page) AS pageFirstPartyHost,
    COUNT(DISTINCT CONCAT(name, domain)) AS distinctNbCookies
  FROM `httparchive.almanac.DATE_CLIENT_RANK_cookies`
  WHERE
    firstPartyCookie IS NOT NULL
  GROUP BY firstPartyCookie, pageFirstPartyHost
)

SELECT
  firstPartyCookie,
  distinctNbCookies,
  COUNT(DISTINCT pageFirstPartyHost) AS nbWebsites
FROM nb_cookies_per_website
GROUP BY firstPartyCookie, distinctNbCookies
ORDER BY firstPartyCookie, distinctNbCookies ASC
