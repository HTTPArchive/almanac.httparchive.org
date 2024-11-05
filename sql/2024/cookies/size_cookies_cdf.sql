-- Extract the size of the cookies
-- Before running query: edit date and client

SELECT
  CAST(size AS INT) AS sizeCookie,
  COUNT(0) AS nbCookies
FROM `httparchive.almanac.cookies`
WHERE
  date = '2024-06-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie IS NOT NULL
GROUP BY sizeCookie
ORDER BY sizeCookie ASC
