WITH RECURSIVE pages AS (
  SELECT
    CASE page -- publisher websites may redirect to an SSP domain, and need to use redirected domain instead of page domain
      WHEN 'https://www.chunkbase.com/' THEN 'cafemedia.com'
      ELSE NET.REG_DOMAIN(page)
    END AS page,
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.line_count') AS INT64) AS line_count
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    is_root_page = TRUE
), ads AS (
  SELECT
    page,
    CEIL(line_count / 100) * 100 AS line_count_bucket,
    COUNT(DISTINCT page) OVER () AS total_pages
  FROM pages
  WHERE line_count > 0
)

SELECT
  line_count_bucket,
  COUNT(DISTINCT page) / ANY_VALUE(total_pages) AS pct_pages,
  COUNT(DISTINCT page) AS number_of_pages
FROM ads
GROUP BY line_count_bucket
ORDER BY line_count_bucket ASC
