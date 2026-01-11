#standardSQL
-- Analyze Client Hints usage by specific CDN provider
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Extract CDN provider and check for Accept-CH header
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
    response_headers
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

-- Count requests with Accept-CH header per CDN
accept_ch_by_cdn AS (
  SELECT
    r.client,
    r.cdn_provider,
    COUNT(0) AS requests_with_accept_ch
  FROM
    cdn_requests r,
    UNNEST(r.response_headers) AS h
  WHERE
    LOWER(h.name) = 'accept-ch' AND
    h.value IS NOT NULL AND
    h.value != ''
  GROUP BY
    r.client,
    r.cdn_provider
)

SELECT
  t.cdn_provider AS `CDN_Provider`,
  t.client AS `Client`,
  t.total_requests AS `Total_Requests`,
  IFNULL(a.requests_with_accept_ch, 0) AS `Requests_with_Accept-CH`,
  ROUND(IFNULL(a.requests_with_accept_ch, 0) / t.total_requests * 100, 2) AS `Pct_with_Accept-CH`
FROM
  total_by_cdn t
LEFT JOIN accept_ch_by_cdn a ON t.client = a.client AND t.cdn_provider = a.cdn_provider
WHERE
  t.total_requests >= 1000  -- Filter to CDNs with meaningful sample size
ORDER BY
  t.total_requests DESC,
  t.cdn_provider,
  t.client
LIMIT 50;
