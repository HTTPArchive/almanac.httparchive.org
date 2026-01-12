-- Extract the expire date (age rounded to closest number of days)
-- (only positive values, non session cookies)
-- Before running query: edit date and client

WITH cookies_age AS (
  SELECT
    ROUND((CAST(expires AS FLOAT64) - CAST(startedDateTime AS FLOAT64)) / (24 * 3600), 0) AS age
  FROM `httparchive.almanac.cookies`
  WHERE
    date = '2025-07-01' AND
    client = 'desktop' AND
    rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
    firstPartyCookie IS NOT NULL AND
    CAST(expires AS FLOAT64) >= 0
)

SELECT
  age,
  COUNT(0) AS nbCookies
FROM cookies_age
GROUP BY age
ORDER BY age ASC
