#standardSQL
-- Analyze common preload patterns in Early Hints
-- Shows how many resources are typically preloaded and common combinations
DECLARE d DATE DEFAULT '2025-07-01';

WITH
-- Count resources preloaded per page
resources_per_page AS (
  SELECT
    r.client,
    r.page,
    CASE
      WHEN IFNULL(NULLIF(REGEXP_EXTRACT(JSON_EXTRACT_SCALAR(r.summary, '$._cdn_provider'), r'^([^,]*).*'), ''), '') = ''
      THEN 'Origin'
      ELSE 'CDN'
    END AS source_type,
    COUNT(*) AS preload_count
  FROM `httparchive.crawl.requests` r,
  UNNEST(JSON_EXTRACT_ARRAY(r.payload, '$._early_hint_headers')) AS hint_header
  WHERE r.date = d
    AND LOWER(JSON_EXTRACT_SCALAR(hint_header, '$')) LIKE '%rel=preload%'
  GROUP BY r.client, r.page, source_type
),

-- Bucket the counts
preload_buckets AS (
  SELECT
    client,
    source_type,
    CASE
      WHEN preload_count = 1 THEN '1 resource'
      WHEN preload_count = 2 THEN '2 resources'
      WHEN preload_count = 3 THEN '3 resources'
      WHEN preload_count BETWEEN 4 AND 5 THEN '4-5 resources'
      WHEN preload_count BETWEEN 6 AND 10 THEN '6-10 resources'
      WHEN preload_count > 10 THEN '10+ resources'
    END AS preload_bucket,
    COUNT(*) AS page_count
  FROM resources_per_page
  GROUP BY client, source_type, preload_bucket
),

-- Get totals for percentages
total_pages_with_preloads AS (
  SELECT
    client,
    source_type,
    COUNT(*) AS total_pages
  FROM resources_per_page
  GROUP BY client, source_type
)

SELECT
  b.preload_bucket AS `Preload Count`,
  b.client AS `Client`,
  b.source_type AS `Source`,
  b.page_count AS `Pages`,
  ROUND(b.page_count / t.total_pages * 100, 2) AS `% of Pages with Early Hints`
FROM preload_buckets b
JOIN total_pages_with_preloads t
  ON b.client = t.client
  AND b.source_type = t.source_type
ORDER BY 
  b.client,
  b.source_type,
  CASE b.preload_bucket
    WHEN '1 resource' THEN 1
    WHEN '2 resources' THEN 2
    WHEN '3 resources' THEN 3
    WHEN '4-5 resources' THEN 4
    WHEN '6-10 resources' THEN 5
    WHEN '10+ resources' THEN 6
  END;
