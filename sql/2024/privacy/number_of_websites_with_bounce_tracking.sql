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
  FROM `httparchive.all.requests`
  WHERE
    date = '2024-06-01' AND
    is_root_page = TRUE AND
    type NOT IN ('css', 'image', 'font', 'video', 'audio') AND
    LEFT(JSON_VALUE(summary, '$.status'), 1) = '3' AND
    index <= 2
), navigation_redirect AS (
  -- Find the first navigation redirect
  SELECT
    client,
    url,
    page,
    headers.value AS navigation_redirect_location
  FROM redirect_requests,
    UNNEST(response_headers) AS headers
  WHERE
    index = 1 AND
    LOWER(headers.name) = 'location' AND
    NET.REG_DOMAIN(page) != NET.REG_DOMAIN(headers.value)
), bounce_redirect AS (
  -- Find the second navigation redirect
  SELECT
    client,
    url,
    page,
    headers.value AS bounce_redirect_location,
    response_headers
  FROM redirect_requests,
    UNNEST(response_headers) AS headers
  WHERE
    index = 2 AND
    LOWER(headers.name) = 'location' AND
    NET.REG_DOMAIN(headers.value) = NET.REG_DOMAIN(page)
), bounce_redirect_with_cookies AS (
  -- Find the cookies set during the second navigation redirect
  SELECT
    client,
    url,
    page,
    bounce_redirect_location
  --response_headers.value AS bounce_tracking_cookies
  FROM bounce_redirect,
    UNNEST(response_headers) AS response_headers
  WHERE
    LOWER(response_headers.name) = 'set-cookie'
), bounce_sequences AS (
  -- Combine the first and second navigation redirects
  SELECT
    nav.client,
    nav.page,
    nav.url AS navigation_url,
    nav.navigation_redirect_location,
    bounce.bounce_redirect_location
  --ARRAY_AGG(bounce.bounce_tracking_cookies) AS bounce_tracking_cookies
  FROM navigation_redirect AS nav
  LEFT JOIN bounce_redirect_with_cookies AS bounce
  ON
    nav.client = bounce.client AND
    nav.page = bounce.page AND
    nav.navigation_redirect_location = bounce.url
  WHERE bounce_redirect_location IS NOT NULL
  GROUP BY
    nav.client,
    page,
    navigation_url,
    navigation_redirect_location,
    bounce_redirect_location
)

-- Count the number of websites with bounce tracking per bounce hostname
SELECT
  client,
  NET.HOST(navigation_redirect_location) AS bounce_hostname,
  COUNT(DISTINCT page) AS number_of_pages
--ARRAY_AGG(page LIMIT 2) AS page_examples
FROM bounce_sequences
GROUP BY client, bounce_hostname
ORDER BY number_of_pages DESC
LIMIT 100
