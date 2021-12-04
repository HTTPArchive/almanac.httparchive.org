#standardSQL
# Counts of US Privacy String values for websites using IAB US Privacy Framework
# cf. https://github.com/InteractiveAdvertisingBureau/USPrivacy/blob/master/CCPA/US%20Privacy%20String.md

WITH totals AS (
  SELECT
    _TABLE_SUFFIX,
    COUNT(0) AS total_websites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    _TABLE_SUFFIX
)

SELECT
  _TABLE_SUFFIX AS client,
  JSON_QUERY(
    JSON_VALUE(payload, "$._privacy"),
    "$.iab_usp.privacy_string.uspString"
  ) AS uspString,
  COUNT(0) AS nb_websites,
  total_websites,
  COUNT(0) / total_websites AS pct_websites
FROM
  `httparchive.pages.2021_07_01_*`
JOIN totals USING (_TABLE_SUFFIX)
WHERE
  JSON_QUERY(
    JSON_VALUE(payload, "$._privacy"),
    "$.iab_usp.privacy_string.uspString"
  ) IS NOT NULL
GROUP BY
  client,
  total_websites,
  uspString
ORDER BY
  pct_websites DESC,
  client,
  uspString
