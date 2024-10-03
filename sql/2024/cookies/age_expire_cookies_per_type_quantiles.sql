-- Extract stats around the expire date (age rounded to closest number of days)
-- (only positive values, non session cookies)
-- Before running query: edit table name

WITH cookies_age AS (
  SELECT
    firstPartyCookie,
    ROUND((CAST(expires AS FLOAT64) - CAST(startedDateTime AS FLOAT64)) / (24 * 3600), 0) AS age
  FROM `httparchive.almanac.DATE_CLIENT_RANK_cookies`
  WHERE
    firstPartyCookie IS NOT NULL AND
    CAST(expires AS FLOAT64) >= 0
)

SELECT
  firstPartyCookie,
  MIN(age) AS min,
  APPROX_QUANTILES(age, 100)[OFFSET(25)] AS p25,
  APPROX_QUANTILES(age, 100)[OFFSET(50)] AS median,
  APPROX_QUANTILES(age, 100)[OFFSET(75)] AS p75,
  APPROX_QUANTILES(age, 100)[OFFSET(90)] AS p90,
  APPROX_QUANTILES(age, 100)[OFFSET(99)] AS p99,
  MAX(age) AS max
FROM cookies_age
GROUP BY firstPartyCookie
