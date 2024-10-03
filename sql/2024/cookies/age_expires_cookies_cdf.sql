-- Extract the expire date (age rounded to closest number of days)
-- (only positive values, non session cookies)
-- Before running query: edit table name

WITH cookies_age AS (
  SELECT
    ROUND((CAST(expires AS FLOAT64) - CAST(startedDateTime AS FLOAT64)) / (24 * 3600), 0) AS age
  FROM `httparchive.almanac.DATE_CLIENT_RANK_cookies`
  WHERE
    firstPartyCookie IS NOT NULL AND
    CAST(expires AS FLOAT64) >= 0
)

SELECT
  age,
  COUNT(0) AS nbCookies
FROM cookies_age
GROUP BY age
ORDER BY age ASC
