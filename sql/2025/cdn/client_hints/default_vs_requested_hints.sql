#standardSQL
-- Analyze which Client Hints are sent by default vs. those requiring Accept-CH
-- Compares hint usage on pages WITH and WITHOUT Accept-CH header
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Classify pages by whether they have Accept-CH
pages_with_accept_ch AS (
  SELECT DISTINCT
    r.client,
    r.page
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(r.response_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) = 'accept-ch' AND
    h.value IS NOT NULL AND
    h.value != ''
),

-- Count hint usage on pages WITH Accept-CH
hints_with_accept_ch AS (
  SELECT
    r.client,
    LOWER(h.name) AS hint_name,
    COUNT(DISTINCT r.page) AS pages_using_hint
  FROM
    `httparchive.crawl.requests` r
  INNER JOIN
    pages_with_accept_ch p ON r.client = p.client AND r.page = p.page,
    UNNEST(r.request_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) LIKE 'sec-ch-%'
  GROUP BY
    r.client,
    hint_name
),

-- Count hint usage on pages WITHOUT Accept-CH
hints_without_accept_ch AS (
  SELECT
    r.client,
    LOWER(h.name) AS hint_name,
    COUNT(DISTINCT r.page) AS pages_using_hint
  FROM
    `httparchive.crawl.requests` r
  LEFT JOIN
    pages_with_accept_ch p ON r.client = p.client AND r.page = p.page,
    UNNEST(r.request_headers) AS h
  WHERE
    r.date = d AND
    LOWER(h.name) LIKE 'sec-ch-%' AND
    p.page IS NULL  -- Pages WITHOUT Accept-CH
  GROUP BY
    r.client,
    hint_name
),

-- Get total page counts for percentage calculations
page_counts AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS total_pages
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = d
  GROUP BY
    client
),

pages_with_accept_ch_count AS (
  SELECT
    client,
    COUNT(DISTINCT page) AS pages_with_accept_ch
  FROM
    pages_with_accept_ch
  GROUP BY
    client
),

-- Dictionary for categorization
hint_dict AS (
  SELECT *
  FROM UNNEST([
    STRUCT('sec-ch-ua' AS hint_name, 'User-Agent' AS category, 'Low' AS entropy, TRUE AS is_default_hint),
    ('sec-ch-ua-mobile', 'User-Agent', 'Low', TRUE),
    ('sec-ch-ua-platform', 'User-Agent', 'Low', TRUE),
    ('sec-ch-ua-platform-version', 'User-Agent', 'High', FALSE),
    ('sec-ch-ua-model', 'Device', 'High', FALSE),
    ('sec-ch-ua-full-version-list', 'User-Agent', 'High', FALSE),
    ('sec-ch-ua-arch', 'Device', 'High', FALSE),
    ('sec-ch-ua-bitness', 'Device', 'High', FALSE),
    ('sec-ch-ua-wow64', 'Device', 'High', FALSE),
    ('sec-ch-ua-full-version', 'User-Agent', 'High', FALSE),
    ('sec-ch-prefers-color-scheme', 'User Preference', 'Low', FALSE),
    ('sec-ch-viewport-width', 'Viewport', 'High', FALSE),
    ('sec-ch-dpr', 'Device', 'High', FALSE),
    ('sec-ch-device-memory', 'Device', 'High', FALSE),
    ('sec-ch-ua-form-factors', 'Device', 'High', FALSE),
    ('sec-ch-viewport-height', 'Viewport', 'High', FALSE),
    ('sec-ch-prefers-reduced-motion', 'User Preference', 'Low', FALSE),
    ('sec-ch-prefers-reduced-transparency', 'User Preference', 'Low', FALSE),
    ('sec-ch-width', 'Viewport', 'High', FALSE)
  ])
)

SELECT
  d.hint_name AS `Client_Hint`,
  d.category AS `Category`,
  d.entropy AS `Entropy`,
  d.is_default_hint AS `Default_Hint`,

  -- Mobile stats
  IFNULL(wm.pages_using_hint, 0) AS `Mobile_Pages_WITH_Accept-CH`,
  IFNULL(nm.pages_using_hint, 0) AS `Mobile_Pages_WITHOUT_Accept-CH`,
  ROUND(IFNULL(wm.pages_using_hint, 0) / NULLIF(pm.pages_with_accept_ch, 0) * 100, 2) AS `Pct_Mobile_WITH_Accept-CH`,
  ROUND(IFNULL(nm.pages_using_hint, 0) / NULLIF((tm.total_pages - pm.pages_with_accept_ch), 0) * 100, 2) AS `Pct_Mobile_WITHOUT_Accept-CH`,

  -- Desktop stats
  IFNULL(wd.pages_using_hint, 0) AS `Desktop_Pages_WITH_Accept-CH`,
  IFNULL(nd.pages_using_hint, 0) AS `Desktop_Pages_WITHOUT_Accept-CH`,
  ROUND(IFNULL(wd.pages_using_hint, 0) / NULLIF(pd.pages_with_accept_ch, 0) * 100, 2) AS `Pct_Desktop_WITH_Accept-CH`,
  ROUND(IFNULL(nd.pages_using_hint, 0) / NULLIF((td.total_pages - pd.pages_with_accept_ch), 0) * 100, 2) AS `Pct_Desktop_WITHOUT_Accept-CH`

FROM
  hint_dict d
LEFT JOIN hints_with_accept_ch wm ON d.hint_name = wm.hint_name AND wm.client = 'mobile'
LEFT JOIN hints_without_accept_ch nm ON d.hint_name = nm.hint_name AND nm.client = 'mobile'
LEFT JOIN hints_with_accept_ch wd ON d.hint_name = wd.hint_name AND wd.client = 'desktop'
LEFT JOIN hints_without_accept_ch nd ON d.hint_name = nd.hint_name AND nd.client = 'desktop'
LEFT JOIN page_counts tm ON tm.client = 'mobile'
LEFT JOIN page_counts td ON td.client = 'desktop'
LEFT JOIN pages_with_accept_ch_count pm ON pm.client = 'mobile'
LEFT JOIN pages_with_accept_ch_count pd ON pd.client = 'desktop'
ORDER BY
  d.is_default_hint DESC,
  d.entropy,
  d.hint_name;
