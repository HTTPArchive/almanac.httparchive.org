#standardSQL
# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(*) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    1
),

pages_iab_usp AS (
  SELECT
    client,
    JSON_QUERY(metrics, "$.iab_usp.privacy_string") AS metrics
  FROM
    pages_privacy
  WHERE
    JSON_QUERY(metrics, "$.iab_usp.privacy_string") IS NOT NULL
)

SELECT
  client,
  JSON_VALUE(metrics, '$.uspString') AS uspString,
  COUNT(0) AS nb_websites,
  ROUND(COUNT(0) / MIN(total_nb_pages.total_nb_pages), 2) AS pct_websites
FROM
  pages_iab_usp JOIN total_nb_pages USING (client)
WHERE
  JSON_VALUE(metrics, '$.uspString') IS NOT NULL
GROUP BY
  1, 2
