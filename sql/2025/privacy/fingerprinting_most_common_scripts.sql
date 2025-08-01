WITH pages AS (
  SELECT
    page,
    client,
    custom_metrics,
    COUNT(DISTINCT page) OVER (PARTITION BY client) AS total_pages
  FROM `httparchive.crawl.pages`
  WHERE date = '2025-07-01'
)

SELECT
  client,
  script,
  COUNT(DISTINCT page) AS page_count,
  COUNT(DISTINCT page) / any_value(total_pages) AS pct_pages
FROM pages,
  UNNEST(JSON_QUERY_ARRAY(custom_metrics, '$.privacy.fingerprinting.likelyFingerprintingScripts')) AS script
GROUP BY
  client,
  script
ORDER BY
  page_count DESC
LIMIT 100;
