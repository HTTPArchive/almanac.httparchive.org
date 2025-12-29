#standardSQL
-- Compare Client Hints adoption between CDN and origin requests
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Classify requests as CDN or origin
requests_classified AS (
  SELECT
    client,
    CASE
      WHEN IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = ''
        THEN 'Origin'
      ELSE 'CDN'
    END AS source_type,
    response_headers
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = d
),

-- Count total requests
total_requests AS (
  SELECT
    client,
    source_type,
    COUNT(0) AS total_requests
  FROM
    requests_classified
  GROUP BY
    client,
    source_type
),

-- Count requests with Accept-CH header (server requesting hints)
accept_ch_requests AS (
  SELECT
    r.client,
    r.source_type,
    COUNT(0) AS requests_with_accept_ch
  FROM
    requests_classified r,
    UNNEST(r.response_headers) AS h
  WHERE
    LOWER(h.name) = 'accept-ch' AND
    h.value IS NOT NULL AND
    h.value != ''
  GROUP BY
    r.client,
    r.source_type
)

SELECT
  t.client AS `Client`,
  t.source_type AS `Source`,
  t.total_requests AS `Total_Requests`,
  IFNULL(a.requests_with_accept_ch, 0) AS `Requests_with_Accept-CH`,
  ROUND(IFNULL(a.requests_with_accept_ch, 0) / t.total_requests * 100, 2) AS `Pct_with_Accept-CH`
FROM
  total_requests t
LEFT JOIN accept_ch_requests a ON t.client = a.client AND t.source_type = a.source_type
ORDER BY
  t.client,
  t.source_type;
