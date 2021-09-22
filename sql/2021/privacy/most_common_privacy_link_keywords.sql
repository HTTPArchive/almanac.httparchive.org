#standardSQL
# Pages with certain keywords indicating privacy-related links

WITH privacy_link_keywords AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY(
      SELECT DISTINCT kw FROM
        UNNEST(JSON_QUERY_ARRAY(metrics, "$._privacy.privacy_wording_links")) AS p,
        UNNEST(JSON_VALUE_ARRAY(p, '$._privacy.keywords')) kw
    ) AS keywords_per_site
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
    client
)

SELECT
  client,
  keyword,
  COUNT(0) AS nb_websites_with_keyword,
  COUNT(0) / MIN(total_nb_pages.total_nb_pages) AS pct_websites_with_keyword
FROM
  privacy_link_keywords
JOIN
  total_nb_pages
USING (client),
  UNNEST(keywords_per_site) keyword
GROUP BY
  client,
  keyword
ORDER BY
  client ASC,
  nb_websites_with_keyword DESC,
  keyword ASC
