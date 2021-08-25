#standardSQL
# Pages with certain keywords indicating privacy-related links

WITH pages_privacy AS (
  SELECT
    _TABLE_SUFFIX AS client,
    JSON_VALUE(payload, "$._privacy") AS metrics
  FROM
    `httparchive.pages.2021_07_01_*`
),

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    1
),

privacy_link_keywords AS (
  SELECT
    client,
    ARRAY(
      SELECT DISTINCT kw FROM
        UNNEST(JSON_QUERY_ARRAY(metrics, "$.privacy_wording_links")) AS p,
        UNNEST(JSON_VALUE_ARRAY(p, '$.keywords')) kw
    ) AS keywords_per_site
  FROM
    pages_privacy
)

SELECT
  client,
  keyword,
  COUNT(0) AS nb_websites_with_keyword,
  ROUND(COUNT(0) / MIN(total_nb_pages.total_nb_pages), 2) AS pct_websites_with_keyword
FROM
  privacy_link_keywords JOIN total_nb_pages USING (client),
  UNNEST(keywords_per_site) keyword
GROUP BY
  1, 2
ORDER BY
  3 DESC
