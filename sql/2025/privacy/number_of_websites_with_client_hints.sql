-- noqa: disable=PRS
WITH base_totals AS (
  SELECT
    client,
    COUNT(DISTINCT root_page) AS total_websites
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
    --AND rank = 1000
  GROUP BY client
),

accept_ch_headers AS (
  SELECT DISTINCT
    client,
    root_page
  FROM `httparchive.crawl.requests`,
    UNNEST(response_headers) response_header
  WHERE
    date = '2025-07-01' AND
    is_main_document = TRUE AND
    --rank = 1000 AND
    LOWER(response_header.name) = 'accept-ch'
),

accept_ch_meta AS (
  SELECT DISTINCT
    client,
    root_page
  FROM (
    SELECT
      client,
      root_page,
      custom_metrics.other.almanac AS metrics
    FROM `httparchive.crawl.pages`
    WHERE date = '2025-07-01'
      --AND rank = 1000
  ),
    UNNEST(JSON_QUERY_ARRAY(metrics.`meta-nodes`.nodes)) AS meta_node
  WHERE LOWER(SAFE.STRING(meta_node.`http-equiv`)) = 'accept-ch'
),

-- Combine both sources
all_accept_ch AS (
  SELECT client, root_page FROM accept_ch_headers
  UNION DISTINCT
  SELECT client, root_page FROM accept_ch_meta
)

FROM all_accept_ch
|> JOIN base_totals USING (client)
|> AGGREGATE
  COUNT(DISTINCT all_accept_ch.root_page) AS number_of_websites,
  COUNT(DISTINCT all_accept_ch.root_page) / ANY_VALUE(base_totals.total_websites) AS pct_websites
GROUP BY all_accept_ch.client
|> PIVOT(
  ANY_VALUE(number_of_websites) AS websites_count,
  ANY_VALUE(pct_websites) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop
|> ORDER BY websites_count_mobile + websites_count_desktop DESC
