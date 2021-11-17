#standardSQL
# Pages that deploy a certain tracker (as defined by WhoTracks.me, i.e., one tracker can run on multiple domains)

CREATE TEMP FUNCTION isTrackerCategory(category STRING)
RETURNS BOOL
AS (
  category = 'advertising' OR
  category = 'pornvertising' OR
  category = 'site_analytics' OR
  category = 'social_media'
);

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
  tracker,
  category,
  tracker || ' (' || category || ')' AS tracker_and_category,
  isTrackerCategory(category) AS isTracker,
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
  date = "2021-07-01" AND
  NET.REG_DOMAIN(page) != NET.REG_DOMAIN(urlShort) -- third party
GROUP BY
  client,
  tracker,
  category,
  isTracker,
  total_websites
ORDER BY
  pct_websites DESC,
  client
LIMIT 1000
