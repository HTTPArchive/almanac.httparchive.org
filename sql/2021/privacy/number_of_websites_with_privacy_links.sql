#standardSQL
# Percent of pages with privacy-related links

SELECT
  _TABLE_SUFFIX AS client,
  COUNT(0) AS total_websites,
  COUNTIF(
    ARRAY_LENGTH(JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.privacy_wording_links")) > 0
  ) AS websites_with_privacy_link,
  COUNTIF(
    ARRAY_LENGTH(JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.privacy_wording_links")) > 0
  ) / COUNT(0) AS pct_websites_with_privacy_link
FROM
  `httparchive.pages.2021_07_01_*`
GROUP BY
  client
ORDER BY
  client
