-- noqa: disable=PRS
-- Detection logic explained:
-- https://github.com/privacycg/proposals/issues/6
-- https://github.com/privacycg/nav-tracking-mitigations/blob/main/bounce-tracking-explainer.md

WITH redirect_requests AS (
  FROM `httparchive.crawl.requests`
  |> WHERE
    date = '2025-07-01' AND
    --rank = 1000 AND
    SAFE.INT64(summary.status) BETWEEN 300 AND 399 AND
    index <= 2
  |> JOIN UNNEST(response_headers) AS header
  |> WHERE LOWER(header.name) = 'location'
  |> SELECT
    client,
    url,
    index,
    NET.REG_DOMAIN(header.value) AS location_domain,
    root_page
),

-- Find the first navigation redirect
navigation_redirect AS (
  FROM redirect_requests
  |> WHERE
    index = 1 AND
    NET.REG_DOMAIN(root_page) = NET.REG_DOMAIN(url) AND
    NET.REG_DOMAIN(url) != location_domain
  |> SELECT
    client,
    root_page,
    location_domain AS bounce_domain
),

-- Find the second navigation redirect
bounce_redirect AS (
  FROM redirect_requests
  |> WHERE
    index = 2 AND
    NET.REG_DOMAIN(root_page) != NET.REG_DOMAIN(url) AND
    NET.REG_DOMAIN(url) != location_domain
  |> SELECT
    client,
    url,
    root_page,
    location_domain AS bounce_redirect_location_domain
),

-- Combine the first and second navigation redirects
bounce_sequences AS (
  FROM navigation_redirect AS nav
  |> JOIN bounce_redirect AS bounce
  ON
    nav.client = bounce.client AND
    nav.root_page = bounce.root_page
  |> AGGREGATE COUNT(DISTINCT nav.root_page) AS websites_count
  GROUP BY nav.client, bounce_domain
),

websites_total AS (
  FROM `httparchive.crawl.pages`
  |> WHERE date = '2025-07-01' --AND rank = 1000
  |> AGGREGATE COUNT(DISTINCT root_page) AS total_websites GROUP BY client
)

FROM bounce_sequences
|> JOIN websites_total USING (client)
|> EXTEND websites_count / total_websites AS websites_pct
|> DROP total_websites
|> PIVOT(
  ANY_VALUE(websites_count) AS cnt,
  ANY_VALUE(websites_pct) AS pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME pct_mobile AS mobile, pct_desktop AS desktop, cnt_mobile AS mobile_count, cnt_desktop AS desktop_count
|> ORDER BY COALESCE(mobile_count, 0) + COALESCE(desktop_count, 0) DESC
|> LIMIT 100
