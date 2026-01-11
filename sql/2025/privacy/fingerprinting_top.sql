-- noqa: disable=PRS
-- Percent of websites using a fingerprinting library based on wappalyzer category

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS websites_total
  FROM httparchive.crawl.pages
  WHERE date = '2025-07-01'
  GROUP BY client
)

FROM httparchive.crawl.pages,
  UNNEST(technologies) AS technology,
  UNNEST(technology.categories) AS category
|> WHERE
  date = '2025-07-01' AND
  category = 'Browser fingerprinting'
|> AGGREGATE
  COUNT(DISTINCT root_page) AS websites_count
GROUP BY client, technology.technology
|> JOIN base_totals USING (client)
|> EXTEND websites_count / websites_total AS websites_pct
|> DROP websites_total
|> PIVOT(
  ANY_VALUE(websites_count) AS websites_count,
  ANY_VALUE(websites_pct) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME websites_count_mobile AS mobile, websites_count_desktop AS desktop
|> ORDER BY mobile + desktop DESC
