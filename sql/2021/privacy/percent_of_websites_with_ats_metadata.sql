#standardSQL
# Counts of pages with Ads Transparency Spotlight metadata

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

SELECT
  client,
  COUNT(0) nb_websites,
  COUNTIF(JSON_VALUE(metrics, "$.ads_transparency_spotlight.present") = "true") AS nb_websites_ats,
  COUNTIF(JSON_VALUE(metrics, "$.ads_transparency_spotlight.present") = "true") / COUNT(0) AS pct_websites_ats
FROM
  pages_privacy
GROUP BY
  1