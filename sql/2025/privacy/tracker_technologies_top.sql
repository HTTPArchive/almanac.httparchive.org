-- noqa: disable=PRS

WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
  GROUP BY client
)

FROM `httparchive.crawl.pages`,
  UNNEST(technologies) AS tech,
  UNNEST(tech.categories) AS category
|> WHERE
  date = '2025-07-01' AND
  category IN (
    'Analytics', 'Browser fingerprinting', 'Customer data platform',
    'Geolocation',
    'Advertising', 'Retargeting', 'Personalisation', 'Segmentation',
    'Cookie compliance'
  )
|> AGGREGATE COUNT(DISTINCT root_page) AS number_of_websites GROUP BY client, tech.technology
|> JOIN base_totals USING (client)
|> EXTEND number_of_websites / total_websites AS pct_websites
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS Mobile, pct_desktop AS Desktop
|> ORDER BY COALESCE(websites_count_desktop, 0) + COALESCE(websites_count_mobile, 0) DESC
