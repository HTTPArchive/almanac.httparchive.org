# Number of websites that deploy a certain number of trackers
WITH whotracksme AS (
  SELECT
    domain,
    category,
    tracker
  FROM almanac.whotracksme
  WHERE date = '2024-06-01'
),
totals AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_websites
  FROM httparchive.crawl.requests
  WHERE date = '2024-06-01'
  GROUP BY client
)

SELECT
  client,
  'any' AS type,
  number_of_trackers,
  COUNT(DISTINCT page) AS number_of_websites,
  total_websites,
  COUNT(DISTINCT page) / total_websites AS pct_websites
FROM (
  SELECT
    client,
    page,
    COUNT(DISTINCT tracker) AS number_of_trackers
  FROM httparchive.crawl.requests
  JOIN whotracksme
  ON (
    NET.HOST(url) = domain OR
    ENDS_WITH(NET.HOST(url), CONCAT('.', domain))
  )
  WHERE
    date = '2024-06-01' AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url)
  GROUP BY
    client,
    page
  )
JOIN
  totals
USING (client)
GROUP BY
  client,
  number_of_trackers,
  total_websites
UNION ALL
SELECT
  client,
  'any_tracker' AS type,
  number_of_trackers,
  COUNT(DISTINCT page) AS number_of_websites,
  total_websites,
  COUNT(DISTINCT page) / total_websites AS pct_websites
FROM (
  SELECT
    client,
    page,
    COUNT(DISTINCT tracker) AS number_of_trackers
  FROM httparchive.almanac.requests
  JOIN
    whotracksme
  ON (
    NET.HOST(urlShort) = domain OR
    ENDS_WITH(NET.HOST(urlShort), CONCAT('.', domain))
  )
  WHERE
    date = '2024-06-01' AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url) AND -- third party
    (
      -- categories selected from https://whotracks.me/blog/tracker_categories.html
      whotracksme.category = 'advertising' OR
      whotracksme.category = 'pornvertising' OR
      whotracksme.category = 'site_analytics' OR
      whotracksme.category = 'social_media'
    )
  GROUP BY
    client,
    page
  )
JOIN
  totals
USING (client)
GROUP BY
  client,
  number_of_trackers,
  total_websites
ORDER BY
  client,
  type,
  number_of_trackers
