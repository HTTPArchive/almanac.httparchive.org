#standardSQL
# Pages that deploy at least one tracker from a certain category

WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM
    `httparchive.almanac.whotracksme`
  WHERE
    date = '2021-07-01'
)

SELECT
  client,
  category,
  COUNT(DISTINCT page) AS number_of_websites
FROM
  `httparchive.almanac.requests`
JOIN
  whotracksme
ON (
  NET.HOST(urlShort) = domain OR
  ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
)
WHERE
  date = "2021-07-01" AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) -- third party
GROUP BY
  client,
  category
UNION ALL
SELECT
  client,
  'any' AS category,
  COUNT(DISTINCT page) AS number_of_websites
FROM
  `httparchive.almanac.requests`
JOIN
  whotracksme
ON (
  NET.HOST(urlShort) = domain OR
  ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
)
WHERE
  date = "2021-07-01" AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) -- third party
GROUP BY
  client
ORDER BY
  client,
  number_of_websites DESC
