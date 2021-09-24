#standardSQL
# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH pages_iab_usp AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_QUERY(JSON_VALUE(payload, "$._privacy"), "$.iab_usp.privacy_string") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
  WHERE
    JSON_QUERY(JSON_VALUE(payload, "$._privacy"), "$.iab_usp.privacy_string") IS NOT NULL
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_websites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  JSON_VALUE(metrics, '$.uspString') AS uspString,
  COUNT(0) AS nb_websites,
  total_websites,
  COUNT(0) / ANY_VALUE(total_websites) AS pct_websites
FROM
  pages_iab_usp
JOIN
  totals
USING (client)
WHERE
  JSON_VALUE(metrics, '$.uspString') IS NOT NULL
GROUP BY
  client,
  uspString,
  total_websites
ORDER BY
  client ASC,
  nb_websites DESC
