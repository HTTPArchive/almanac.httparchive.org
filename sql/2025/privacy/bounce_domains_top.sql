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
    page
),

-- Find the first navigation redirect
navigation_redirect AS (
  FROM redirect_requests
  |> WHERE
    index = 1 AND
    NET.REG_DOMAIN(page) = NET.REG_DOMAIN(url) AND
    NET.REG_DOMAIN(url) != location_domain
  |> SELECT
    client,
    page,
    location_domain AS bounce_domain
),

-- Find the second navigation redirect
bounce_redirect AS (
  FROM redirect_requests
  |> WHERE
    index = 2 AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(url) AND
    NET.REG_DOMAIN(url) != location_domain
  |> SELECT
    client,
    url,
    page,
    location_domain AS bounce_redirect_location_domain
),

-- Combine the first and second navigation redirects
bounce_sequences AS (
  FROM navigation_redirect AS nav
  |> JOIN bounce_redirect AS bounce
  ON
    nav.client = bounce.client AND
    nav.page = bounce.page
  |> AGGREGATE COUNT(DISTINCT nav.page) AS pages_count
  GROUP BY nav.client, bounce_domain
),

pages_total AS (
  FROM `httparchive.crawl.pages`
  |> WHERE date = '2025-07-01' --AND rank = 1000
  |> AGGREGATE COUNT(DISTINCT page) AS total_pages GROUP BY client
)

FROM bounce_sequences
|> JOIN pages_total USING (client)
|> EXTEND pages_count / total_pages AS pages_pct
|> DROP total_pages
|> PIVOT(
  ANY_VALUE(pages_count) AS cnt,
  ANY_VALUE(pages_pct) AS pages_pct
  FOR client IN ('desktop', 'mobile')
)
|> RENAME cnt_mobile AS mobile, cnt_desktop AS desktop
|> ORDER BY mobile + desktop DESC
|> LIMIT 100
