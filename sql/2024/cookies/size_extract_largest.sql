-- Extract largest cookies being set
-- Before running query: edit table name

SELECT
  name,
  domain,
  CAST(size AS INT) AS sizeCookie
FROM `httparchive.almanac.<DATE>_<CLIENT>_<RANK>_cookies`
WHERE
  firstPartyCookie = TRUE
ORDER BY sizeCookie DESC
LIMIT 10