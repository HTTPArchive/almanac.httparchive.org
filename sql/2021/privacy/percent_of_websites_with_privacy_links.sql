#standardSQL
# Percent of pages with privacy-related links

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_EXTRACT_SCALAR(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)

SELECT
  client,
  COUNT(0) AS total_websites,
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(metrics, "$.privacy_wording_links") AS INT64) > 0) AS websites_with_privacy_link,
  COUNTIF(CAST(JSON_EXTRACT_SCALAR(metrics, "$.privacy_wording_links") AS INT64) > 0) / COUNT(0) AS pct_websites_with_privacy_link
FROM
  pages_privacy
GROUP BY
  client