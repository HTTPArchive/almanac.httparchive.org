#standardSQL
# Percent of certain texts containing keywords indicating privacy-related links

WITH privacy_link_texts AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY(
      SELECT DISTINCT
        JSON_VALUE(p, '$._privacy.text')
      FROM
        UNNEST(JSON_QUERY_ARRAY(metrics, "$._privacy.privacy_wording_links")) AS p
    ) AS texts_per_site
  FROM
    `httparchive.pages.2021_07_01_*`
)

total_nb_pages AS (
  SELECT
    _TABLE_SUFFIX AS client,
    COUNT(0) AS total_nb_pages
  FROM
    `httparchive.pages.2021_07_01_*`
  GROUP BY
    1
)

SELECT
  client,
  text,
  COUNT(0) AS nb_websites_with_text,
  COUNT(0) / MIN(total_nb_pages.total_nb_pages) AS pct_websites_with_text
FROM
  privacy_link_texts
JOIN
  total_nb_pages
USING (client),
  UNNEST(texts_per_site) text
GROUP BY
  1, 2
ORDER BY
  3 DESC
