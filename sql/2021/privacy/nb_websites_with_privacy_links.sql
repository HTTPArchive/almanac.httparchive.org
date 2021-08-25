#standardSQL
# Percent of pages with privacy-related links

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
)

SELECT
  client,
  COUNT(0) AS total_websites,
  COUNTIF(ARRAY_LENGTH(JSON_QUERY_ARRAY(metrics, "$.privacy_wording_links")) > 0) AS websites_with_privacy_link,
  COUNTIF(ARRAY_LENGTH(JSON_QUERY_ARRAY(metrics, "$.privacy_wording_links")) > 0) / COUNT(0) AS pct_websites_with_privacy_link
FROM
  pages_privacy
GROUP BY
  client
ORDER BY
  1 ASC
