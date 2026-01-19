-- noqa: disable=PRS
WITH totals AS (
  FROM `httparchive.crawl.pages`
  |> WHERE date = '2025-07-01' AND is_root_page --AND rank = 1000
  |> AGGREGATE COUNT(*) AS total_websites GROUP BY client
),

/* Get Accept-CH Headers */
headers AS (
  FROM `httparchive.crawl.requests`
  |> WHERE date = '2025-07-01' AND is_root_page AND is_main_document --AND rank = 1000
  |> JOIN UNNEST(response_headers) AS header
  |> WHERE LOWER(header.name) = 'accept-ch'
  |> LEFT JOIN UNNEST(SPLIT(LOWER(header.value), ',')) AS header_value
  |> SELECT client, root_page, header_value

),

/* Get Accept-CH Meta Tags */
meta_tags AS (
  FROM `httparchive.crawl.pages`
  |> WHERE date = '2025-07-01' AND is_root_page --AND rank = 1000
  |> JOIN UNNEST(JSON_QUERY_ARRAY(custom_metrics.other.almanac.`meta-nodes`.nodes)) AS meta_node
  |> EXTEND LOWER(SAFE.STRING(meta_node.`http-equiv`)) AS tag_name
  |> WHERE tag_name = 'accept-ch'
  |> LEFT JOIN UNNEST(SPLIT(LOWER(SAFE.STRING(meta_node.content)), ',')) AS tag_value
  |> SELECT client, root_page, tag_value
)

FROM headers
|> FULL OUTER JOIN meta_tags USING (client, root_page)
|> JOIN totals USING (client)
|> EXTEND TRIM(COALESCE(header_value, tag_value)) AS value
|> AGGREGATE
COUNT(DISTINCT root_page) AS number_of_websites,
COUNT(DISTINCT root_page) / ANY_VALUE(total_websites) AS pct_websites
GROUP BY client, value
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS Mobile, pct_desktop AS Desktop
|> ORDER BY COALESCE(websites_count_desktop, 0) + COALESCE(websites_count_mobile, 0) DESC
