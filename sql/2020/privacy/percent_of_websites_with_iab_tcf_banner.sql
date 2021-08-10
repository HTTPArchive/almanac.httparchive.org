#standardSQL
# Percent of pages with IAB Transparency & Consent Framework

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2020_08_01_*`
)

SELECT
  client,
  COUNT(0) AS total_websites,
  COUNTIF(JSON_EXTRACT_SCALAR(metrics, "$.iab_tcf") = "1") AS websites_with_iab,
  COUNTIF(JSON_EXTRACT_SCALAR(metrics, "$.iab_tcf") = "1") / COUNT(0) AS pct_iab_banner_pages
FROM
  pages_privacy
GROUP BY
  client
