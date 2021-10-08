#standardSQL
# Pages that deploy a certain tracker (as defined by WhoTracks.me, i.e., one tracker can run on multiple domains)

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
  tracker,
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
  tracker
ORDER BY
  client,
  number_of_websites DESC
