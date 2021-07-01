#standardSQL
# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)
, pages_iab_usp AS (
  SELECT 
    client, 
    JSON_EXTRACT(metrics, "$.iab_usp.privacy_string") AS metrics
  FROM
    pages_privacy
  WHERE 
    JSON_EXTRACT(metrics, "$.iab_usp.privacy_string") is not null
)

SELECT 
  client,
  JSON_VALUE(metrics, '$.uspString') uspString,
  COUNT(0) AS nb_websites,
  COUNT(0) / (SELECT COUNT(0) FROM pages_iab_usp) pct_websites
FROM
  pages_iab_usp
WHERE
  JSON_VALUE(metrics, '$.uspString') is not null
GROUP BY
  1, 2
