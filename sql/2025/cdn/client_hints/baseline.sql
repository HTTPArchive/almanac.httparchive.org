#standardSQL
-- Baseline Client Hints adoption metrics for context
-- Measures both server-side (Accept-CH) and client-side (Sec-CH-*) adoption
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Total requests baseline
total_requests AS (
  SELECT
    client,
    COUNT(0) AS total_requests,
    COUNT(DISTINCT page) AS total_pages
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = d
  GROUP BY
    client
),

-- Requests with Accept-CH header (servers requesting hints)
accept_ch_stats AS (
  SELECT
    r.client,
    COUNT(0) AS requests_with_accept_ch,
    COUNT(DISTINCT r.page) AS pages_with_accept_ch
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(r.response_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) = 'accept-ch' AND
    h.value IS NOT NULL AND
    h.value != ''
  GROUP BY
    r.client
),

-- Requests with any Sec-CH-* header (clients sending hints)
-- Use DISTINCT to count each request only once, even if it has multiple hint headers
client_hints_sent AS (
  SELECT
    client,
    COUNT(0) AS requests_with_hints,
    COUNT(DISTINCT page) AS pages_sending_hints
  FROM (
    SELECT DISTINCT
      r.client,
      r.page,
      r.url  -- Use url to uniquely identify each request
    FROM
      `httparchive.crawl.requests` r,
      UNNEST(r.request_headers) AS h
    WHERE
      r.date = d AND
      LOWER(h.name) LIKE 'sec-ch-%'
  )
  GROUP BY
    client
),

-- Count distinct hint types being sent
hint_diversity AS (
  SELECT
    r.client,
    COUNT(DISTINCT LOWER(h.name)) AS distinct_hint_types
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(r.request_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) LIKE 'sec-ch-%'
  GROUP BY
    r.client
)

SELECT
  t.client AS `Client`,
  t.total_requests AS `Total_Requests`,
  t.total_pages AS `Total_Pages`,

  -- Server-side adoption (Accept-CH)
  IFNULL(a.requests_with_accept_ch, 0) AS `Requests_with_Accept-CH`,
  IFNULL(a.pages_with_accept_ch, 0) AS `Pages_with_Accept-CH`,
  ROUND(IFNULL(a.requests_with_accept_ch, 0) / t.total_requests * 100, 2) AS `Pct_Requests_with_Accept-CH`,
  ROUND(IFNULL(a.pages_with_accept_ch, 0) / t.total_pages * 100, 2) AS `Pct_Pages_with_Accept-CH`,

  -- Client-side adoption (Sec-CH-*)
  IFNULL(c.requests_with_hints, 0) AS `Requests_Sending_Hints`,
  IFNULL(c.pages_sending_hints, 0) AS `Pages_Sending_Hints`,
  ROUND(IFNULL(c.requests_with_hints, 0) / t.total_requests * 100, 2) AS `Pct_Requests_Sending_Hints`,
  ROUND(IFNULL(c.pages_sending_hints, 0) / t.total_pages * 100, 2) AS `Pct_Pages_Sending_Hints`,

  -- Diversity
  IFNULL(h.distinct_hint_types, 0) AS `Distinct_Hint_Types_in_Use`

FROM
  total_requests t
LEFT JOIN accept_ch_stats a ON t.client = a.client
LEFT JOIN client_hints_sent c ON t.client = c.client
LEFT JOIN hint_diversity h ON t.client = h.client
ORDER BY
  t.client;
