#standardSQL
-- Baseline Early Hints (HTTP 103) adoption metrics
-- Measures overall adoption of Early Hints responses
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

-- Requests_with_Early_Hints (HTTP 103 status)
early_hints_requests AS (
  SELECT
    client,
    COUNT(0) AS requests_with_early_hints,
    COUNT(DISTINCT page) AS pages_with_early_hints
  FROM
    `httparchive.crawl.requests`
  WHERE
    date = d AND
    JSON_EXTRACT_ARRAY(payload, '$._early_hint_headers') IS NOT NULL
  GROUP BY
    client
),

-- Count distinct resource types being preloaded via Early Hints
resource_types_preloaded AS (
  SELECT
    r.client,
    COUNT(
      DISTINCT
      LOWER(
        REGEXP_EXTRACT(
          hint_header,
          r'as=([^;,]+)'
        )
      )
    ) AS distinct_resource_types
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(JSON_EXTRACT_ARRAY(payload, '$._early_hint_headers')) AS hint_header
  WHERE
    r.date = d AND
    hint_header LIKE '%rel=preload%'
  GROUP BY
    r.client
),

-- Count pages using Link headers in Early Hints
link_header_usage AS (
  SELECT
    r.client,
    COUNT(DISTINCT r.page) AS pages_with_link_headers
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(JSON_EXTRACT_ARRAY(payload, '$._early_hint_headers')) AS hint_header
  WHERE
    r.date = d AND
    LOWER(hint_header) LIKE '%link:%'
  GROUP BY
    r.client
)

SELECT
  t.client AS `Client`,
  t.total_requests AS `Total_Requests`,
  t.total_pages AS `Total_Pages`,

  -- Early Hints adoption
  IFNULL(e.requests_with_early_hints, 0) AS `Requests_with_Early_Hints`,
  IFNULL(e.pages_with_early_hints, 0) AS `Pages_with_Early_Hints`,
  ROUND(IFNULL(e.requests_with_early_hints, 0) / t.total_requests * 100, 4) AS `Pct_Requests_with_Early_Hints`,
  ROUND(IFNULL(e.pages_with_early_hints, 0) / t.total_pages * 100, 4) AS `Pct_Pages_with_Early_Hints`,

  -- Link header usage
  IFNULL(l.pages_with_link_headers, 0) AS `Pages_with_Link_Headers`,
  ROUND(IFNULL(l.pages_with_link_headers, 0) / t.total_pages * 100, 4) AS `Pct_Pages_with_Link_Headers`,

  -- Resource diversity
  IFNULL(rt.distinct_resource_types, 0) AS `Distinct_Resource_Types_Preloaded`

FROM
  total_requests t
LEFT JOIN early_hints_requests e ON t.client = e.client
LEFT JOIN link_header_usage l ON t.client = l.client
LEFT JOIN resource_types_preloaded rt ON t.client = rt.client
ORDER BY
  t.client;
