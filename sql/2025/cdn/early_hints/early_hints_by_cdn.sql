#standardSQL
-- Analyze Early Hints usage by specific CDN provider
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Extract CDN provider and check for Early Hints
cdn_requests AS (
  SELECT
    client,
    IFNULL(
      NULLIF(
        REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'),
        ''
      ),
      'Origin'
    ) AS cdn_provider,
    JSON_EXTRACT_ARRAY(payload, '$._early_hint_headers') AS early_hint_headers
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = d
),

-- Count total requests per CDN
total_by_cdn AS (
  SELECT
    client,
    cdn_provider,
    COUNT(0) AS total_requests
  FROM
    cdn_requests
  GROUP BY
    client,
    cdn_provider
),

-- Count requests with Early Hints per CDN
early_hints_by_cdn AS (
  SELECT
    client,
    cdn_provider,
    COUNT(0) AS requests_with_early_hints
  FROM
    cdn_requests
  WHERE
    early_hint_headers IS NOT NULL
  GROUP BY
    client, cdn_provider
)

SELECT
  t.cdn_provider AS `CDN_Provider`,
  t.client AS `Client`,
  t.total_requests AS `Total_Requests`,
  IFNULL(e.requests_with_early_hints, 0) AS `Requests_with_Early_Hints`,
  ROUND(IFNULL(e.requests_with_early_hints, 0) / t.total_requests * 100, 4) AS `Pct_with_Early_Hints`
FROM
  total_by_cdn t
LEFT JOIN early_hints_by_cdn e ON t.client = e.client AND t.cdn_provider = e.cdn_provider
WHERE
  t.total_requests >= 1000  -- Filter to CDNs with meaningful sample size
ORDER BY
  IFNULL(e.requests_with_early_hints, 0) DESC,
  t.total_requests DESC
LIMIT 50;
