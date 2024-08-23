#standardSQL
# Analyze the usage of viewport tags and scaling behavior by domain rank

SELECT
  client,  # Client domain
  rank_grouping,  # Grouping of domains by their rank (e.g., top 1000, 10000, etc.)
  COUNT(0) AS total_pages,  # Total number of pages scanned
  COUNTIF(meta_viewport IS NOT NULL) AS total_viewports,  # Number of pages with a meta viewport tag
  COUNTIF(REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL) AS total_no_scale,  # Pages where zooming is disabled
  COUNTIF(SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1) AS total_locked_max_scale,  # Pages with max-scale set to 1 or less
  COUNTIF(REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL OR SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1) AS total_either,  # Pages with either zoom disabled or max-scale locked
  
  COUNTIF(REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL) / COUNT(0) AS pct_pages_no_scale,  # Percentage of pages with zoom disabled
  COUNTIF(SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1) / COUNT(0) AS pct_pages_locked_max_scale,  # Percentage of pages with max-scale locked
  COUNTIF(REGEXP_EXTRACT(meta_viewport, r'(?i)user-scalable\s*=\s*(no|0)') IS NOT NULL OR SAFE_CAST(REGEXP_EXTRACT(meta_viewport, r'(?i)maximum-scale\s*=\s*([0-9]*\.[0-9]+|[0-9]+)') AS FLOAT64) <= 1) / COUNT(0) AS pct_pages_either  # Percentage of pages with either condition
FROM (
  SELECT
    client,  # Client domain
    page,  # Page URL
    JSON_EXTRACT_SCALAR(payload, '$._meta_viewport') AS meta_viewport  # Extract meta viewport content from JSON payload
  FROM
    `httparchive.all.pages`
  WHERE
    date = '2024-06-01'  # Filter for the specific date
),
UNNEST([1000, 10000, 100000, 1000000, 10000000, 100000000]) AS rank_grouping
GROUP BY
  rank_grouping,  # Group by domain rank grouping
  client  # Group by client domain
ORDER BY
  client,  # Order by client domain
  rank_grouping;  # Order by rank grouping
