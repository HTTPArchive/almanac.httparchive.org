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
  |> SELECT client, page, header_value

),

/* Get Accept-CH Meta Tags */
meta_tags AS (
  FROM `httparchive.crawl.pages`
  |> WHERE date = '2025-07-01' AND is_root_page --AND rank = 1000
  |> JOIN UNNEST(JSON_QUERY_ARRAY(custom_metrics.other.almanac.`meta-nodes`.nodes)) AS meta_node
  |> EXTEND
  LOWER(SAFE.STRING(meta_node.`http-equiv`)) AS tag_name,
  |> WHERE tag_name = 'accept-ch'
  |> LEFT JOIN UNNEST(SPLIT(LOWER(SAFE.STRING(meta_node.content)), ',')) AS tag_value
  |> SELECT client, page, tag_value
)

FROM headers
|> FULL OUTER JOIN meta_tags USING (client, page)
|> JOIN totals USING (client)
|> EXTEND TRIM(COALESCE(header_value, tag_value)) AS value
|> AGGREGATE
COUNT(DISTINCT page) AS number_of_pages,
COUNT(DISTINCT page) / ANY_VALUE(total_websites) AS pct_pages
GROUP BY client, value
|> PIVOT(
  ANY_VALUE(number_of_pages) AS pages_count,
  ANY_VALUE(pct_pages) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME
pct_mobile AS mobile,
pct_desktop AS desktop
|> ORDER BY pages_count_mobile + pages_count_desktop DESC
|> LIMIT 200
