WITH RECURSIVE pages AS (
  SELECT
    NET.REG_DOMAIN(page) AS page,
    custom_metrics
  FROM `httparchive.all.pages`
  WHERE date = '2024-06-01' AND
    client = 'desktop' AND
    is_root_page = TRUE AND
    rank <= 10000
), ads AS (
  SELECT
    CASE page
      WHEN 'chunkbase.com' THEN 'adthrive.com'
      ELSE page
      END AS page,
    CEIL(CAST(JSON_VALUE(custom_metrics, '$.ads.ads.line_count') AS INT64)/100)*100 AS line_count_bucket
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
