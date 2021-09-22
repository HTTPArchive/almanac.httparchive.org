#standardSQL
# Counts of pages with Ads Transparency Spotlight metadata

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS nb_websites,
  COUNTIF(JSON_VALUE(metrics, "$._privacy.ads_transparency_spotlight.present") = "true") AS nb_websites_ats,
  COUNTIF(JSON_VALUE(metrics, "$._privacy.ads_transparency_spotlight.present") = "true") / COUNT(0) AS pct_websites_ats
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  1
ORDER BY
  1 ASC
