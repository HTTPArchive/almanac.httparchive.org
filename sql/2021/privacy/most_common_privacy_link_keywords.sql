#standardSQL
# Pages with certain keywords indicating privacy-related links

WITH privacy_link_keywords AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY(
      SELECT DISTINCT LOWER(kw) FROM
        UNNEST(JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.privacy_wording_links")) AS p,
        UNNEST(JSON_VALUE_ARRAY(p, '$.keywords')) kw
    ) AS keywords_per_site
  FROM
    `httparchive.pages.2021_07_01_*`
),

totals AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_websites
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    client
)

SELECT
  client,
  keyword,
  COUNT(0) AS number_of_websites_with_keyword,
  total_websites,
  COUNT(0) / total_websites AS pct_websites_with_keyword
FROM
  privacy_link_keywords
JOIN
  totals
USING (client),
  UNNEST(keywords_per_site) keyword
GROUP BY
  client,
  keyword,
  total_websites
ORDER BY
  client,
  number_of_websites_with_keyword DESC,
  keyword
