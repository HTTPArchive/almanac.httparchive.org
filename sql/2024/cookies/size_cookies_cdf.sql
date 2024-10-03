-- Extract the size of the cookies
-- Before running query: edit table name

SELECT
  CAST(size AS INT) AS sizeCookie,
  COUNT(0) AS nbCookies
FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`
WHERE
  firstPartyCookie IS NOT NULL
GROUP BY sizeCookie
ORDER BY sizeCookie ASC