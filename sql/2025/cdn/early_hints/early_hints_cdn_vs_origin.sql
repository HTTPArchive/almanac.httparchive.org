#standardSQL
-- Compare Early Hints adoption between CDN and origin requests
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
    END AS source_type
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

-- Count requests with Early Hints
early_hints_requests AS (
  SELECT
    r.client,
    CASE
      WHEN IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(r.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = ''
        THEN 'Origin'
      ELSE 'CDN'
    END AS source_type,
    COUNT(0) AS requests_with_early_hints
  FROM
    `httparchive.crawl.requests` r
  WHERE
    r.date = d AND
    JSON_EXTRACT_ARRAY(r.payload, '$._early_hint_headers') IS NOT NULL
  GROUP BY
    r.client,
    source_type
)

SELECT
  t.client AS `Client`,
  t.source_type AS `Source`,
  t.total_requests AS `Total_Requests`,
  IFNULL(e.requests_with_early_hints, 0) AS `Requests_with_Early_Hints`,
  ROUND(IFNULL(e.requests_with_early_hints, 0) / t.total_requests * 100, 4) AS `Pct_with_Early_Hints`
FROM
  total_requests t
LEFT JOIN early_hints_requests e ON t.client = e.client AND t.source_type = e.source_type
ORDER BY
  t.client,
  t.source_type;
