#standardSQL
# Group Lighthouse scores by top-level domain (TLD)

WITH tld_score_data AS (
  SELECT
    REGEXP_EXTRACT(page, r'://[^/]+\.(\w{2,})/') AS tld,  -- Extract the top-level domain (TLD)
    CAST(JSON_VALUE(lighthouse.categories.performance.score) AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(lighthouse.categories.accessibility.score) AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(lighthouse.categories.`best-practices`.score) AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(lighthouse.categories.seo.score) AS FLOAT64) AS seo_score
  FROM
    `httparchive.crawl.pages`
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    lighthouse.categories IS NOT NULL AND
    is_root_page
)

SELECT
  tld,  -- Group by top-level domain
  AVG(performance_score) AS avg_performance_score,
  AVG(accessibility_score) AS avg_accessibility_score,
  AVG(best_practices_score) AS avg_best_practices_score,
  AVG(seo_score) AS avg_seo_score,
  COUNT(0) AS total_pages
FROM
  tld_score_data
GROUP BY
  tld
ORDER BY
  avg_accessibility_score DESC;  -- Sort by accessibility score, or another metric of interest
