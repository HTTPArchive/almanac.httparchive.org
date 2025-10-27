WITH score_data AS (
  SELECT
    client,
    page,
    rank,
    CAST(JSON_VALUE(lighthouse.categories.performance.score) AS FLOAT64) AS performance_score,
    CAST(JSON_VALUE(lighthouse.categories.accessibility.score) AS FLOAT64) AS accessibility_score,
    CAST(JSON_VALUE(lighthouse.categories.`best-practices`.score) AS FLOAT64) AS best_practices_score,
    CAST(JSON_VALUE(lighthouse.categories.seo.score) AS FLOAT64) AS seo_score,
    t.technology AS framework
  FROM
    `httparchive.crawl.pages`,
    UNNEST(technologies) AS t
  WHERE
    date = '2025-07-01' AND
    lighthouse IS NOT NULL AND
    lighthouse.categories IS NOT NULL AND
    is_root_page = TRUE AND
    ('Web frameworks' IN UNNEST(t.categories) OR 'JavaScript libraries' IN UNNEST(t.categories) OR 'Frontend frameworks' IN UNNEST(t.categories) OR 'JavaScript frameworks' IN UNNEST(t.categories)) AND
    t.technology IS NOT NULL
)

SELECT
  client,
  framework,
  AVG(performance_score) AS avg_performance_score,
  AVG(accessibility_score) AS avg_accessibility_score,
  AVG(best_practices_score) AS avg_best_practices_score,
  AVG(seo_score) AS avg_seo_score,
  COUNT(DISTINCT page) AS total_pages
FROM (
  SELECT
    client,
    page,
    framework,
    AVG(performance_score) AS performance_score, # All scores are the same for one page (we have multiple rows due to unnest), we could also take the first instead of the average
    AVG(accessibility_score) AS accessibility_score,
    AVG(best_practices_score) AS best_practices_score,
    AVG(seo_score) AS seo_score
  FROM
    score_data
  GROUP BY
    client,
    page,
    framework
)
GROUP BY
  client,
  framework
ORDER BY
  total_pages DESC;
