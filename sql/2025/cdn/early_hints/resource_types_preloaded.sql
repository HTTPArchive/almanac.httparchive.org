#standardSQL
-- Analyze which resource types are being preloaded via Early Hints
-- Shows what types of resources (scripts, styles, fonts, etc.) are prioritized
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Extract resource types from Link headers in Early Hints
resource_preloads AS (
  SELECT
    r.client,
    CASE
      WHEN IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(r.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = ''
        THEN 'Origin'
      ELSE 'CDN'
    END AS source_type,
    LOWER(
      TRIM(
        REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(hint_header, '$'), r'as=([^;,\s]+)')
      )
    ) AS resource_type
  FROM
    `httparchive.crawl.requests` r,
    UNNEST(JSON_EXTRACT_ARRAY(r.payload, '$._early_hint_headers')) AS hint_header
  WHERE
    r.date = d AND
    LOWER(JSON_EXTRACT_SCALAR(hint_header, '$')) LIKE '%rel=preload%' AND
    REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(hint_header, '$'), r'as=([^;,\s]+)') IS NOT NULL
),

-- Count occurrences of each resource type
resource_counts AS (
  SELECT
    client,
    source_type,
    resource_type,
    COUNT(0) AS preload_count
  FROM
    resource_preloads
  WHERE
    resource_type IS NOT NULL AND
    resource_type != ''
  GROUP BY
    client,
    source_type,
    resource_type
),

-- Get totals for percentage calculation
total_preloads AS (
  SELECT
    client,
    source_type,
    COUNT(0) AS total_preloads
  FROM
    resource_preloads
  WHERE
    resource_type IS NOT NULL AND
    resource_type != ''
  GROUP BY
    client,
    source_type
)

SELECT
  r.resource_type AS `Resource_Type`,
  r.client AS `Client`,
  r.source_type AS `Source`,
  r.preload_count AS `Preload_Count`,
  ROUND(r.preload_count / t.total_preloads * 100, 2) AS `Pct_of_Preloads`
FROM
  resource_counts r
JOIN
  total_preloads t
ON r.client = t.client AND r.source_type = t.source_type
ORDER BY
  r.preload_count DESC,
  r.resource_type;
