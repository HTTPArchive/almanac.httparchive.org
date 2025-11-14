#standardSQL
# Average Lighthouse scores per geo (by country and device)

WITH geo_summary AS (
  SELECT
    `chrome-ux-report`.experimental.GET_COUNTRY(country_code) AS geo,
    IF(device = 'desktop', 'desktop', 'mobile') AS client,
    origin,
    COUNT(DISTINCT origin) OVER (PARTITION BY country_code, IF(device = 'desktop', 'desktop', 'mobile')) AS total
  FROM
    `chrome-ux-report.materialized.country_summary`
  WHERE
    yyyymm = 202507  -- Use June 2024 dataset
),

score_data AS (
  SELECT
    REGEXP_EXTRACT(page, r'://([^/]+)') AS domain,  -- Extract top-level domain from page
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
  geo_summary.geo,
  geo_summary.client,
  AVG(score_data.performance_score) AS avg_performance_score,
  AVG(score_data.accessibility_score) AS avg_accessibility_score,
  AVG(score_data.best_practices_score) AS avg_best_practices_score,
  AVG(score_data.seo_score) AS avg_seo_score,
  COUNT(DISTINCT score_data.domain) AS total_domains
FROM
  geo_summary
JOIN
  score_data
ON REGEXP_EXTRACT(geo_summary.origin, r'://([^/]+)') = score_data.domain
GROUP BY
  geo_summary.geo, geo_summary.client
ORDER BY
  avg_accessibility_score DESC;
