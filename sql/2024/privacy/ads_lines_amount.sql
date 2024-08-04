WITH RECURSIVE pages AS (
  SELECT
    CASE page -- publisher websites may redirect to an SSP domain, and need to use redirected domain instead of page domain
      WHEN 'https://www.chunkbase.com/' THEN 'cafemedia.com'
      ELSE NET.REG_DOMAIN(page)
    END AS page,
    custom_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    client = 'desktop' AND
    is_root_page = TRUE AND
    rank <= 10000
), ads AS (
  SELECT
    page,
    CEIL(CAST(JSON_VALUE(custom_metrics, '$.ads.ads.line_count') AS INT64) / 100) * 100 AS line_count_bucket
  FROM pages
  WHERE
    CAST(JSON_VALUE(custom_metrics, '$.ads.ads.line_count') AS INT64) > 0
)

SELECT
  line_count_bucket,
  COUNT(DISTINCT page) AS page_count
FROM ads
GROUP BY line_count_bucket
ORDER BY line_count_bucket ASC
