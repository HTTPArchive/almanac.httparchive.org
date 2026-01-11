#standardSQL
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Count requests per Client Hint and client (mobile/desktop)
hint_counts AS (
  SELECT
    LOWER(h.name) AS client_hint,
    r.client,
    COUNT(0) AS requests
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(r.request_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) LIKE 'sec-ch-%'
  GROUP BY
    client_hint,
    r.client
),

-- Pivot to mobile/desktop columns
hint_rollup AS (
  SELECT
    client_hint,
    SUM(CASE WHEN client = 'mobile' THEN requests ELSE 0 END) AS mobile_requests,
    SUM(CASE WHEN client = 'desktop' THEN requests ELSE 0 END) AS desktop_requests
  FROM
    hint_counts
  GROUP BY
    client_hint
),

-- Dictionary for Category/Entropy
dict AS (
  SELECT *
  FROM UNNEST([
    STRUCT('sec-ch-ua' AS client_hint, 'User-Agent' AS category, 'Low' AS entropy, 1 AS ord),
    ('sec-ch-ua-mobile', 'User-Agent', 'Low', 2),
    ('sec-ch-ua-platform', 'User-Agent', 'Low', 3),
    ('sec-ch-ua-platform-version', 'User-Agent', 'High', 4),
    ('sec-ch-ua-model', 'Device', 'High', 5),
    ('sec-ch-ua-full-version-list', 'User-Agent', 'High', 6),
    ('sec-ch-ua-arch', 'Device', 'High', 7),
    ('sec-ch-ua-bitness', 'Device', 'High', 8),
    ('sec-ch-ua-wow64', 'Device', 'High', 9),
    ('sec-ch-ua-full-version', 'User-Agent', 'High', 10),
    ('sec-ch-prefers-color-scheme', 'User Preference', 'Low', 11),
    ('sec-ch-viewport-width', 'Viewport', 'High', 12),
    ('sec-ch-dpr', 'Device', 'High', 13),
    ('sec-ch-device-memory', 'Device', 'High', 14),
    ('sec-ch-ua-form-factors', 'Device', 'High', 15),
    ('sec-ch-viewport-height', 'Viewport', 'High', 16),
    ('sec-ch-prefers-reduced-motion', 'User Preference', 'Low', 17),
    ('sec-ch-prefers-reduced-transparency', 'User Preference', 'Low', 18),
    ('sec-ch-width', 'Viewport', 'High', 19)
  ])
)

SELECT
  d.client_hint AS `Client_Hint`,
  d.category AS `Category`,
  d.entropy AS `Entropy`,
  IFNULL(r.mobile_requests, 0) AS `Mobile_Requests`,
  IFNULL(r.desktop_requests, 0) AS `Desktop_Requests`,
  IFNULL(r.mobile_requests, 0) + IFNULL(r.desktop_requests, 0) AS `Total_Requests`
FROM
  dict d
LEFT JOIN hint_rollup r USING (client_hint)
ORDER BY
  d.ord;
