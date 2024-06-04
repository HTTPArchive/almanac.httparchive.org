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
),

totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_websites
  FROM
    `httparchive.almanac.requests`
  WHERE
    date = '2021-07-01'
  GROUP BY
    client
)

SELECT
  client,
  category,
  COUNT(DISTINCT page) AS number_of_websites,
  total_websites,
  COUNT(DISTINCT page) / total_websites AS pct_websites
FROM
  `httparchive.almanac.requests`
JOIN
  whotracksme
ON (
  NET.HOST(urlShort) = domain OR
  ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
)
JOIN
  totals
USING (client)
WHERE
  date = '2021-07-01' AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) -- third party
GROUP BY
  client,
  category,
  total_websites
UNION ALL
SELECT
  client,
  'any' AS category,
  COUNT(DISTINCT page) AS number_of_websites,
  total_websites,
  COUNT(DISTINCT page) / total_websites AS pct_websites
FROM
  `httparchive.almanac.requests`
JOIN
  whotracksme
ON (
  NET.HOST(urlShort) = domain OR
  ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
)
JOIN
  totals
USING (client)
WHERE
  date = '2021-07-01' AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) -- third party
GROUP BY
  client,
  total_websites
UNION ALL
SELECT
  client,
  'any_tracker' AS category,
  COUNT(DISTINCT page) AS number_of_websites,
  total_websites,
  COUNT(DISTINCT page) / total_websites AS pct_websites
FROM
  `httparchive.almanac.requests`
JOIN
  whotracksme
ON (
  NET.HOST(urlShort) = domain OR
  ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
)
JOIN
  totals
USING (client)
WHERE
  date = '2021-07-01' AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) AND (
    -- third party categories selected from https://whotracks.me/blog/tracker_categories.html
    whotracksme.category = 'advertising' OR
    whotracksme.category = 'pornvertising' OR
    whotracksme.category = 'site_analytics' OR
    whotracksme.category = 'social_media'
  )
GROUP BY
  client,
  total_websites
ORDER BY
  client,
  number_of_websites DESC
