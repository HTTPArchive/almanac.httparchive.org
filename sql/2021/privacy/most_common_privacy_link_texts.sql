#standardSQL
# Percent of certain texts containing keywords indicating privacy-related links

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_08_01_*`
)
, privacy_link_texts AS (
  SELECT
    client,
    ARRAY(
      SELECT DISTINCT JSON_VALUE(p, '$.text') FROM 
        UNNEST(JSON_QUERY_ARRAY(metrics, "$.privacy_wording_links")) AS p
      ) AS texts_per_site  FROM
    pages_privacy
)

SELECT 
  client,
  text,
  COUNT(0) nb_websites_with_text,
  COUNT(0) / (SELECT COUNT(0) FROM pages_privacy) pct_websites_with_text
FROM 
  privacy_link_texts, 
  UNNEST(texts_per_site) text 
GROUP BY
  1, 2