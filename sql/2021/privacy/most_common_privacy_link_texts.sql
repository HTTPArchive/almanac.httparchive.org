#standardSQL
# Percent of certain texts containing keywords indicating privacy-related links

WITH privacy_link_texts AS (
  SELECT
    _TABLE_SUFFIX AS client,
    ARRAY(
      SELECT DISTINCT
        LOWER(JSON_VALUE(p, '$.text'))
      FROM
        UNNEST(JSON_QUERY_ARRAY(JSON_VALUE(payload, "$._privacy"), "$.privacy_wording_links")) AS p
    ) AS texts_per_site
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
  text,
  COUNT(0) AS number_of_websites_with_text,
  total_websites,
  COUNT(0) / total_websites AS pct_websites_with_text
FROM
  privacy_link_texts
JOIN
  totals
USING (client),
  UNNEST(texts_per_site) text
GROUP BY
  client,
  text,
  total_websites
ORDER BY
  client,
  number_of_websites_with_text DESC,
  text
