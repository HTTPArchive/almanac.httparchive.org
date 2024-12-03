-- Detection logic explained:
-- https://github.com/privacycg/proposals/issues/6
-- https://github.com/privacycg/nav-tracking-mitigations/blob/main/bounce-tracking-explainer.md
WITH redirect_requests AS (
  SELECT
    client,
    url,
    index,
    response_headers,
    page
  FROM `httparchive.crawl.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    type NOT IN ('css', 'image', 'font', 'video', 'audio') AND
    ROUND(INT64(summary.status) / 100) = 3 AND
    index <= 2
), navigation_redirect AS (
  -- Find the first navigation redirect
  SELECT
    client,
    url,
    page,
    response_header.value AS navigation_redirect_location
  FROM redirect_requests,
    UNNEST(response_headers) AS response_header
  WHERE
    index = 1 AND
    LOWER(response_header.name) = 'location' AND
    NET.REG_DOMAIN(response_header.value) != NET.REG_DOMAIN(page)
), bounce_redirect AS (
  -- Find the second navigation redirect
  SELECT
    client,
    url,
    page,
    response_header.value AS bounce_redirect_location,
    response_headers
  FROM redirect_requests,
    UNNEST(response_headers) AS response_header
  WHERE
    index = 2 AND
    LOWER(response_header.name) = 'location'
), bounce_sequences AS (
  -- Combine the first and second navigation redirects
  SELECT
    nav.client,
    NET.REG_DOMAIN(navigation_redirect_location) AS bounce_hostname,
    COUNT(DISTINCT nav.page) AS number_of_pages
  --ARRAY_AGG(bounce.bounce_tracking_cookies) AS bounce_tracking_cookies
  FROM navigation_redirect AS nav
  LEFT JOIN bounce_redirect AS bounce
  ON
    nav.client = bounce.client AND
    nav.page = bounce.page AND
    nav.navigation_redirect_location = bounce.url
  WHERE bounce_redirect_location IS NOT NULL
  GROUP BY
    nav.client,
    bounce_hostname
), pages_total AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM `httparchive.crawl.pages`
  WHERE date = '2024-06-01' AND
    is_root_page
  GROUP BY client
)

-- Count the number of websites with bounce tracking per bounce hostname
SELECT
  client,
  bounce_hostname,
  number_of_pages,
  number_of_pages / total_pages AS pct_pages
FROM bounce_sequences
JOIN pages_total
USING (client)
ORDER BY number_of_pages DESC
LIMIT 100
