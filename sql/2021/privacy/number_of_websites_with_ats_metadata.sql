#standardSQL
# Counts of pages with Ads Transparency Spotlight metadata

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS number_of_websites,
  COUNTIF(JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.ads_transparency_spotlight.present") = "true") AS number_of_websites_ats,
  COUNTIF(JSON_VALUE(JSON_VALUE(payload, "$._privacy"), "$.ads_transparency_spotlight.present") = "true") / COUNT(0) AS pct_websites_ats
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  client
ORDER BY
  client,
  number_of_websites
