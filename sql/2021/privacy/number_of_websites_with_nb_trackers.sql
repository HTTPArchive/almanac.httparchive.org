#standardSQL
# Number of websites that deploy a certain number of trackers

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
  'any' AS type,
  number_of_trackers,
  COUNT(DISTINCT page) AS number_of_websites
FROM (
  SELECT
    client,
    page,
    COUNT(DISTINCT tracker) AS number_of_trackers
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
    page
  )
GROUP BY
  client,
  number_of_trackers
UNION ALL
SELECT
  client,
  'no_cdn_or_hosting' AS type,
  number_of_trackers,
  COUNT(DISTINCT page) AS number_of_websites
FROM (
  SELECT
    client,
    page,
    COUNT(DISTINCT tracker) AS number_of_trackers
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
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) AND -- third party
    whotracksme.category != 'cdn' AND
    whotracksme.category != 'hosting'
  GROUP BY
    client,
    page
  )
GROUP BY
  client,
  number_of_trackers
ORDER BY
  client,
  type,
  number_of_trackers
