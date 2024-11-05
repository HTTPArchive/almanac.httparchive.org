-- Extract largest cookies being set
-- Before running query: edit date and client

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.cookies`
WHERE
  date = '2024-06-01' AND
  client = 'desktop' AND
  rank <= 1000000 AND --2024 results were mainly extracted for top 1M cookies, feel free to remove this and expand in future
  firstPartyCookie = TRUE
ORDER BY sizeCookie DESC
LIMIT 10
